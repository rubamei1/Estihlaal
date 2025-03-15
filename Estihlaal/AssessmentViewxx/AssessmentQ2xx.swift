////
////  AssessmentQ2.swift
////  Estihlaal
////
////  Created by Maryam Amer Bin Siddique on 05/09/1446 AH.
////
//
//import SwiftUI
//
//struct AssessmentQ2: View {
//    @ObservedObject var viewModel: AssessmentViewModel
//    @Environment(\.presentationMode) var presentationMode
//    @State private var selectedMajor: String? = nil
//    @State private var navigateToNext = false
//    @State private var navigateToOverview = false
//    
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ProgressBarView(totalSteps: 4, currentStep: 1, activeColor: Color("main"), inactiveColor: Color.gray)
//                    .padding(.top, 10)
//                
//                Text("What is your major?")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 20)
//                    .padding(.top, 40)
//                
//                VStack(spacing: 15) {
//                    ForEach(viewModel.majorsByField[viewModel.selectedField ?? ""] ?? [], id: \.self) { major in
//                        RadioButton(title: major, selectedOption: $viewModel.selectedMajor, navigateToNext: $navigateToNext)
//                    }
//                }
//
//                Spacer()
//
//                NavigationLink(destination: AssessmentQ3(viewModel: viewModel), isActive: $navigateToNext) {
//                    Text("Continue")
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 30)
//                        .padding()
//                        .background(viewModel.selectedMajor != nil ? Color("accent") : Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 50)
//                .disabled(viewModel.selectedMajor == nil)
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
//                NavigationLink(destination: OverviewPage(viewModel: viewModel), isActive: $navigateToOverview) {
//                    EmptyView()
//                }
//            }
//            .padding(.top)
//            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Background")
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
////    AssessmentQ2()
////}
