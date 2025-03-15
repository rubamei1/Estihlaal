//
//  Untitled.swift
//  Estihlaal
//
//  Created by Reem on 11/09/1446 AH.
////
import SwiftUI

class JobPredictionViewModel: ObservableObject {
    @Published var predictedJobs: [String] = []
    private let api = GroqAPI()

    func fetchPredictedJobs(field: String, major: String, interests: [String], skills: [String]) {
        api.predictJobs(field: field, major: major, interests: interests, skills: skills) { [weak self] jobs in
            DispatchQueue.main.async {
                self?.predictedJobs = jobs
            }
        }
    }
}
