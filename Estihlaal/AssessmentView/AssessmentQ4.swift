
//
//  AssessmentQ4.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 06/09/1446 AH.
//
import SwiftUI

struct AssessmentQ4: View {
    @ObservedObject var viewModel: AssessmentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToJobPositions = false
    @State private var predictedJobs: [String] = []
    @State private var isLoading = false
    private let api = GroqAPI()

    var body: some View {
            VStack {
                ProgressBarView(totalSteps: 4, currentStep: 3, activeColor: Color("main"), inactiveColor: Color.gray)
                    .padding(.top, 10)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("accent"))
                            }
                        }
                    }
                Text("What are your skills?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 40)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.skillsByField[viewModel.selectedField ?? ""] ?? [], id: \.self) { skill in
                            CheckboxButton(title: skill, maxSelection: 3, selectedOptions: $viewModel.selectedSkills)
                        }
                    }
                    .padding(.bottom, 10)
                }

                Spacer()

                Button(action: {
                    fetchJobPredictions()
                }) {
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .padding()
                    } else {
                        Text("Done!")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .padding()
                            .background(viewModel.selectedSkills.count > 0 ? Color("main") : Color("main").opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
                .disabled(viewModel.selectedSkills.isEmpty || isLoading)
                
//                HStack {
//                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
//                        .padding(.leading)
//                    NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
//                    NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)      .padding(.trailing)
//                }
//                .padding(.bottom, 30)
//                .frame(height: 20)
//                .background(
//                    RoundedRectangle(cornerRadius: 30)
//                        .fill(Color(UIColor.systemGray6))
//                        .padding(.bottom, -100).padding(.top, -40)
//                )
                NavigationLink(destination: JobPositionsView(field: viewModel.selectedField ?? "",
                                                             major: viewModel.selectedMajor ?? "",
                                                             interests: viewModel.selectedInterests,
                                                             skills: viewModel.selectedSkills,
                                                             predictedJobs: predictedJobs),
                               isActive: $navigateToJobPositions) {
                    EmptyView()
                }
            }
            .padding(.bottom, 30)
            .padding(.top)
            .navigationBarBackButtonHidden(true)
    }

    private func fetchJobPredictions() {
        guard !isLoading else { return }
        isLoading = true

        api.predictJobs(field: viewModel.selectedField ?? "",
                        major: viewModel.selectedMajor ?? "",
                        interests: viewModel.selectedInterests,
                        skills: viewModel.selectedSkills) { jobs in
            DispatchQueue.main.async {
                self.predictedJobs = jobs
                self.isLoading = false
                self.navigateToJobPositions = true
            }
        }
    }
}
