//
//  EstihlaalApp.swift
//  Estihlaal
//
//  Created by Ruba Meshal Alqahtani on 03/03/2025.
//

import SwiftUI

@main
struct EstihlaalApp: App {
    @StateObject var viewModel = AssessmentViewModel()
    
    var body: some Scene {
        WindowGroup {

            OnboardingView()
            
        }
    }
}
