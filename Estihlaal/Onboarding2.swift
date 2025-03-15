//
//  OnBoarding2.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//

import SwiftUI

struct Onboarding2: View {
    @State private var navigateToOverview = false
    @State private var showOverviewPage = false

    var body: some View {
        NavigationStack {
            ZStack {
                if !showOverviewPage {
                    VStack {
                        Spacer().frame(height: 110)
                        Image("onboarding2")
                            .resizable()
                            .frame(width: 330, height: 275)
                        Spacer().frame(height: 75)
                        
                        Text("Your path... paved for you!")
                            .foregroundColor(.black)
                            .font(.system(size: 48, weight: .black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 20)
                        
                        Text("Get personalized job")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("recommendations tailored to your background, skills, and interests.")
                            .foregroundColor(.black)
                            .font(.system(size: 24, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        HStack {
                            Image("Indicator2")
                                .resizable()
                                .frame(width: 50, height: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showOverviewPage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigateToOverview = true
                                }
                            }) {
                                Text("Skip")
                                    .foregroundColor(.black)
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
    Onboarding2()
}
