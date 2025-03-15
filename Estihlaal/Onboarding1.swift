//
//  ContentView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 03/03/2025.
//

import SwiftUI

struct Onboarding1: View {
    @State private var navigateToOverview = false
    @State private var showOverviewPage = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Main Onboarding View
                if !showOverviewPage {
                    Color("MainColor").ignoresSafeArea()
                    
                    VStack {
                        Spacer().frame(height: 100)
                        Image("onboarding1")
                            .resizable()
                            .frame(width: 320, height: 320)
                        Spacer().frame(height: 40)
                        
                        Text("Build your success!")
                            .foregroundColor(.white)
                            .font(.system(size: 48, weight: .black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 20)
                        
                        Text("With Estihlal, ")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("you will be able to find a clear vision of your future and lasting success.")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        HStack {
                            Image("Indicator")
                                .resizable()
                                .frame(width: 50, height: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showOverviewPage = true
                                }
                                // Slight delay to allow animation before actual nav
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    navigateToOverview = true
                                }
                            }) {
                                Text("Skip")
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

                // Hidden NavigationLink triggers after fade
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
    Onboarding1()
}
