//
//  OnBoarding2.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//
import SwiftUI
struct Onboarding2: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 45)
            Image("onboarding2")
                .resizable()
                .frame(width: 330, height: 275)
            Spacer().frame(height: 80)
            
            Text("Your path... paved for you!")
                .foregroundColor(.black)
                .font(.system(size: 48, weight: .black))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 20)
            
            Text("Get personalized job")
                .foregroundColor(.black)
                .font(.system(size: 24, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Recommendations tailored to your background, skills, and interests.")
                .foregroundColor(.black)
                .font(.system(size: 24, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            HStack {
                Image("Indicator2") 
                    .resizable()
                    .frame(width: 50, height: 10)
                
                Spacer()
                
                Text("Skip")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .bold))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .padding()
    }
}
#Preview {
    Onboarding2()
}
