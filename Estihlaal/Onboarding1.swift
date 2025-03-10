//
//  ContentView.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 03/03/2025.
//

import SwiftUI

struct Onboarding1: View {
    var body: some View {
        ZStack {
            Color("MainColor").ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 20)
                Image("Onboarding1")
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
                
                Text("You will be able to find a clear vision of your future and lasting success.")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                
                HStack {
                    Image("Indicator")
                        .resizable()
                        .frame(width: 50, height: 10)
                    
                    Spacer()
                    
                    Text("Skip")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
}

#Preview {
    Onboarding1()
}
