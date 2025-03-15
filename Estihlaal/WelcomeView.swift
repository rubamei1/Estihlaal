//
//  WelcomeView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//

import SwiftUICore
import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: AssessmentViewModel
    var userName: String // ✅ Accept userName as a parameter

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 230)
                Image("onboarding4")
                    .resizable()
                    .frame(width: 340, height: 290)
                
                Text("Great to have you here,  \(userName)!")
                    .foregroundColor(Color.black)
                    .font(.system(size: 36, weight: .black))
                    .multilineTextAlignment(.center)
                Spacer()
                
//                Button(action: {
//                    
//                }) {
//                    Text("Let's start!")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.black)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal, 30)
                NavigationLink(destination: OverviewPage(viewModel: viewModel, userName: userName)) {
                    Text("Let's start!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
                .padding(.horizontal, 30)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//#Preview {
//    WelcomeView()
//}
