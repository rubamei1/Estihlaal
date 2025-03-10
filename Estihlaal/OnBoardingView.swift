//
//  OnBoardingView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 09/03/2025.
//
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            Onboarding1()
            Onboarding2() // This will have a white background
            Onboarding3()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea() // Ensure the swipe works full screen
    }
}

#Preview {
    OnboardingView()
}
