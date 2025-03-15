////
////  AssessmentQ4.swift
////  Estihlaal
////
////  Created by Maryam Amer Bin Siddique on 06/09/1446 AH.
////
//
//import SwiftUI
//
//struct AssessmentQ4: View {
//    @ObservedObject var viewModel: AssessmentViewModel
//    @Environment(\.presentationMode) var presentationMode
//    @State private var selectedSkills: [String] = []
//    @State private var navigateToNext = false
//    @State private var navigateToOverview = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ProgressBarView(totalSteps: 4, currentStep: 3, activeColor: Color("main"), inactiveColor: Color.gray)
//                    .padding(.top, 10)
//
//                Text("What are your skills?")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 20)
//                    .padding(.top, 40)
//                
//                ScrollView {
//                    VStack(spacing: 15) {
//                        ForEach(viewModel.skillsByField[viewModel.selectedField ?? ""] ?? [], id: \.self) { skill in
//                            CheckboxButton(title: skill, maxSelection: 3, selectedOptions: $viewModel.selectedSkills)
//                        }
//                    }
//                    .padding(.bottom, 10)
//                }
//
//                Spacer()
//                
//                NavigationLink(destination: OverviewPage(viewModel: viewModel), isActive: $navigateToNext) {
//                    Text("Done!")
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 30)
//                        .padding()
//                        .background(viewModel.selectedSkills.count > 0 ? Color("main") : Color("main").opacity(0.3))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 50)
//                .disabled(viewModel.selectedSkills.isEmpty)
//
//                // Navigation Bar
//                HStack {
//                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
//                        .padding(.leading)
//                    NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
//                    NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)      .padding(.trailing)
//                }
//                .frame(height: 20)
//                .background(
//                    RoundedRectangle(cornerRadius: 30)
//                        .fill(Color(UIColor.systemGray6))
//                        .padding(.bottom, -100).padding(.top, -30)
//                )
//                
//                NavigationLink(destination: OverviewPage(viewModel: viewModel), isActive: $navigateToOverview) {
//                    EmptyView()
//                }
//            }
//            .padding(.top)
//            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Personal")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(Color("accent"))
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        navigateToOverview = true
//                    }) {
//                        Image(systemName: "xmark")
//                            .foregroundColor(Color("accent"))
//                    }
//                }
//            }
//        }
//    }
//}
//
////#Preview {
////    AssessmentQ4()
////}
