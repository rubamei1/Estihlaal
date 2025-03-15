//
//  NameView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//

import SwiftUI

struct NameView: View {
    @ObservedObject var viewModel: AssessmentViewModel
    @State private var userInput: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Firstly, what’s\nyour name?")
                        .foregroundColor(.black)
                        .font(.system(size: 36, weight: .black))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Your Name", text: $userInput)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .background(Color.clear)
                            .overlay(
                                Rectangle()
                                    .frame(height: 4)
                                    .foregroundColor(.red)
                                    .padding(.top, 38),
                                alignment: .bottom
                            )
                    }
                }
                
                Spacer()
                
                // ✅ Pass userInput to WelcomeView
                NavigationLink(destination: WelcomeView(viewModel: viewModel, userName: userInput)) {
                    Text("Done")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(userInput.isEmpty ? Color.gray : Color.black)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
                .disabled(userInput.isEmpty)
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
        }
    }
}


//import SwiftUI
//
//struct NameView: View {
//    @State private var userInput: String = ""
//    @ObservedObject var viewModel: AssessmentViewModel
//
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            VStack(alignment: .leading, spacing: 30) {
//                Text("Firstly, what’s\nyour name?")
//                    .foregroundColor(.black)
//                    .font(.system(size: 36, weight: .black))
//                
//                VStack(alignment: .leading, spacing: 5) {
//                    TextField("Your Name", text: $userInput)
//                        .padding(.vertical, 8)
//                        .padding(.horizontal, 10)
//                        .background(Color.clear)
//                        .overlay(
//                            Rectangle()
//                                .frame(height: 4)
//                                .foregroundColor(.red)
//                                .padding(.top, 38), 
//                            alignment: .bottom
//                        )
//                }
//            }
//            
//            Spacer()
//            
////            Button(action: {
////              
////            }) {
////                Text("Done")
////                    .font(.system(size: 20, weight: .bold))
////                    .foregroundColor(.white)
////                    .frame(maxWidth: .infinity)
////                    .padding()
////                    .background(Color.black)
////                    .cornerRadius(10)
////            }
////            //.padding(.horizontal, 30)
//            
//            // ✅ Pass userInput to WelcomeView
//            NavigationLink(destination: WelcomeView(viewModel: viewModel, userName: userInput)) {
//                Text("Done")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(10)
//            }
//        }
//        .padding(.horizontal, 30)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
////#Preview {
////    NameView()
////}
