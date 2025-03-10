//
//  ProgressBarView.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 08/09/1446 AH.
//

import SwiftUI

struct ProgressBarView: View {
    let totalSteps: Int
    let currentStep: Int
    let activeColor: Color
    let inactiveColor: Color
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<totalSteps, id: \.self) { index in
                HStack(spacing: -1) {
                    Circle()
                        .fill(index <= currentStep ? activeColor : inactiveColor)
                        .frame(width: 15, height: 15)

                    if index < totalSteps - 1 {
                        Rectangle()
                            .fill(index < currentStep ? activeColor : inactiveColor)
                            .frame(width: 70, height: 8)
                    }
                }
            }
        }
//        .frame(height: 20)
//        .padding(.horizontal, 40)
    }
}

//#Preview {
//    ProgressBarView()
//}
