//
//  OnBoarding3.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//

import SwiftUI

struct Onboarding3: View {
    @State private var navigateToOverview = false
    @State private var showOverviewPage = false

    var body: some View {
        NavigationStack {
            ZStack {
                if !showOverviewPage {
                    Color("MainColor").ignoresSafeArea()
                    
                    VStack {
                        Spacer().frame(height: 85)
                        Image("onboarding3")
                            .resizable()
                            .frame(width: 290, height: 310)
                        Spacer().frame(height: 60)
                        
                        Text("Ace your interviews!")
                            .foregroundColor(.white)
                            .font(.system(size: 48, weight: .black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 20)
                        
                        Text("Prepare with focused questions and expert insights to interview with confidence.")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        HStack {
                            Image("Indicator3") // The dots at the bottom left
                                .resizable()
                                .frame(width: 50, height: 10) // Adjust size if needed
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showOverviewPage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigateToOverview = true
                                }
                            }) {
                                Text("Let's go!")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    .padding()
                    .transition(.opacity)
                }

                // Hidden NavigationLink
                NavigationLink(
                    destination: NameView(viewModel: AssessmentViewModel())
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToOverview
                ) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    Onboarding3()
}
