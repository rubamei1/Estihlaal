//
//  AssessmentQ3.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 06/09/1446 AH.
//

import SwiftUI

struct AssessmentQ3: View {
    @ObservedObject var viewModel: AssessmentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedInterests: [String] = []
    @State private var navigateToNext = false
    @State private var navigateToOverview = false
    
    var body: some View {
        NavigationStack {
            VStack {
                progressBar
                questionText
                interestsList
                Spacer()
                continueButton
                navigationBar
                
                NavigationLink(destination: OverviewPage(viewModel: viewModel), isActive: $navigateToOverview) {
                    EmptyView()
                }
            }
            .padding(.top)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Personal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    closeButton
                }
            }
        }
    }
    
    
    // Progress Bar
    private var progressBar: some View {
        ProgressBarView(totalSteps: 4, currentStep: 2, activeColor: Color("main"), inactiveColor: Color.gray)
            .padding(.top, 10)
    }
    
    // Question Text
    private var questionText: some View {
        Text("What are your interests?")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 20)
            .padding(.top, 40)
    }
    
    private var interestsList: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(viewModel.interestsByField[viewModel.selectedField ?? ""] ?? [], id: \.self) { interest in
                    CheckboxButton(title: interest, maxSelection: 3, selectedOptions: $viewModel.selectedInterests)
                }
            }
        }
    }
    
    // Continue Button
    private var continueButton: some View {
        NavigationLink(destination: AssessmentQ4(viewModel: viewModel), isActive: $navigateToNext) {
            Text("Continue")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .padding()
                .background(viewModel.selectedInterests.count > 0 ? Color("accent") : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 50)
        .disabled(viewModel.selectedInterests.isEmpty)
    }
    
    // Navigation Bar
    private var navigationBar: some View {
        HStack {
            NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
                .padding(.leading)
            NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
            NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)
                .padding(.trailing)
        }
        .frame(height: 20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(UIColor.systemGray6))
                .padding(.bottom, -100).padding(.top, -30)
        )
    }
    
    // Back Button
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("accent"))
        }
    }
    
    // Close Button
    private var closeButton: some View {
        Button(action: {
            navigateToOverview = true
        }) {
            Image(systemName: "xmark")
                .foregroundColor(Color("accent"))
        }
    }
}

// Checkmarks for selection
struct CheckboxButton: View {
    let title: String
    let maxSelection: Int
    @Binding var selectedOptions: [String]

    var body: some View {
        Button(action: {
            if selectedOptions.contains(title) {
                selectedOptions.removeAll { $0 == title }
            } else if selectedOptions.count < maxSelection {
                selectedOptions.append(title)
            }
        }) {
            HStack {
                ZStack {
                    Circle()
                        .stroke(Color("accent"), lineWidth: 1.5)
                        .frame(width: 15, height: 15)

                    if selectedOptions.contains(title) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 15, height: 15)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.white)
                            )
                    }
                }
                Text(title)
                    .font(.body)
                    .foregroundColor(Color("accent"))
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(Color("secon"))
            .cornerRadius(30)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 5)
    }
}


//#Preview {
//    AssessmentQ3()
//}
