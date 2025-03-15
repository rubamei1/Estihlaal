//
//  AssessmentQ1.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 05/09/1446 AH.
//

import SwiftUI

struct AssessmentQ1: View {
    @ObservedObject var viewModel: AssessmentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedField: String? = nil
    @State private var navigateToNext = false
    
    var body: some View {
        NavigationStack {
            VStack {
//                ProgressView(value: 0.25)
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .tint(Color("main"))
//                    .padding(.horizontal, 60)
                
                ProgressBarView(
                    totalSteps: 4,
                    currentStep: 0,
                    activeColor: Color("main"),
                    inactiveColor: Color.gray
                    )
                .padding(.top, 10)
                
                Text("What is your academic field?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 40)
                
                VStack(spacing: 15) {
                    ForEach(["Technology", "Design", "Business"], id: \.self) { field in
                        RadioButton(title: field, selectedOption: $viewModel.selectedField, navigateToNext: $navigateToNext)
                    }
                }

                Spacer()
                

                NavigationLink(destination: AssessmentQ2(viewModel: viewModel), isActive: $navigateToNext) {
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

//                // Navigation Bar
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
            }
            .padding(.bottom, 30)
            .padding(.top)
        }
        .navigationTitle("Background")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("accent"))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Radio Button
struct RadioButton: View {
    let title: String
    @State private var isSelected: Bool = false
    @Binding var selectedOption: String?
    @Binding var navigateToNext: Bool
    
    var body: some View {
        Button(action: {
            selectedOption = title
        }) {
            HStack {
                Image(systemName: selectedOption == title ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.black)
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)

                Spacer()
            }
            .padding()
//            .frame(maxWidth: .infinity)
            .frame(width: 340 , height: 70)
            .background(Color("secon"))
            .cornerRadius(30)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 5)

    }
}

//#Preview {
//    AssessmentQ1()
//}
