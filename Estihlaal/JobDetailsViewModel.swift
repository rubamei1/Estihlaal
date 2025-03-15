//
//  JobDetailsViewModel.swift
//  EstihlaalVV2
//
//  Created by Reem on 12/09/1446 AH.
//

import SwiftUI
import Combine

class JobDetailsViewModel: ObservableObject {
    @Published var jobDetails: JobDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let api = GroqAPI()

    func fetchJobDetails(jobTitle: String) {
        isLoading = true
        api.fetchJobDetails(jobTitle: jobTitle) { [weak self] details in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let details = details {
                    self?.jobDetails = details
                } else {
                    self?.errorMessage = "Failed to load job details."
                }
            }
        }
    }
}
