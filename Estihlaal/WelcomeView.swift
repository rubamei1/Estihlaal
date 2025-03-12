//
//  WelcomeView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 06/03/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 100)
            Image("onboarding4")
                .resizable()
                .frame(width: 340, height: 290)
            
            Text("Great to have you here, Maryam!")
                .foregroundColor(Color.black)
                .font(.system(size: 36, weight: .black))
            Spacer()
            
            Button(action: {
              
            }) {
                Text("Let's start!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    WelcomeView()
}
