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
import SwiftUI

struct AssessmentQ2: View {
    @ObservedObject var viewModel: AssessmentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedMajor: String? = nil
    @State private var navigateToNext = false
    @State private var navigateToOverview = false

    var body: some View {
            VStack {
                ProgressBarView(totalSteps: 4, currentStep: 1, activeColor: Color("main"), inactiveColor: Color.gray)
                    .padding(.top, 10)

                Text("What is your major?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 40)

                ScrollView { // ✅ Ensures content remains scrollable
                    VStack(spacing: 15) {
                        ForEach(viewModel.majorsByField[viewModel.selectedField ?? ""] ?? [], id: \.self) { major in
                            RadioButton(title: major, selectedOption: $viewModel.selectedMajor, navigateToNext: $navigateToNext)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .scrollIndicators(.hidden)

                VStack {
                    NavigationLink(destination: AssessmentQ3(viewModel: viewModel), isActive: $navigateToNext) {
//                        Text("Continue")
//                            .fontWeight(.bold)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 30)
//                            .padding()
//                            .background(viewModel.selectedMajor != nil ? Color("accent") : Color.gray)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 20)
//                    .disabled(viewModel.selectedMajor == nil)
                        Text("Continue")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 30)
                            .padding()
                            .background(viewModel.selectedField != nil ? Color("accent") : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                    .disabled(viewModel.selectedField == nil)
                }

//                // ✅ Navigation Bar
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

                NavigationLink(destination: OverviewPage(viewModel: viewModel), isActive: $navigateToOverview) {
                    EmptyView()
                }
            }
            .padding(.bottom, 30)
            .padding(.top)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Background")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("accent"))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        navigateToOverview = true
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("accent"))
                    }
                }
            }
    }
}
//struct RadioButton2: View {
//    let title: String
//    @Binding var selectedOption: String?
//    @Binding var navigateToNext: Bool
//
//    var body: some View {
//        Button(action: {
//            selectedOption = title
//            navigateToNext = true
//        }) {
//            HStack {
//                ZStack {
//                    Circle()
//                        .stroke(Color("accent"), lineWidth: 1.5)
//                        .frame(width: 20, height: 20)
//
//                    if selectedOption == title {
//                        Circle()
//                            .fill(Color.black)
//                            .frame(width: 15, height: 15)
//                            .overlay(
//                                Image(systemName: "checkmark")
//                                    .font(.system(size: 10, weight: .bold))
//                                    .foregroundColor(.white)
//                            )
//                    }
//                }
//
//                Text(title)
//                    .font(.system(size: 18))
//                    .foregroundColor(Color("accent"))
//
//                Spacer()
//            }
//            .padding()
////            .frame(maxWidth: .infinity)
//            .frame(width: 340, height: 70)
//
////            .frame(height: 70) // ✅ Ensures uniform height
//            .background(Color("secon"))
//            .cornerRadius(30) // ✅ Match rounded corners with checkboxes
//        }
//        .padding(.horizontal, 30)
//        .padding(.vertical, 5)
//    }
//}
