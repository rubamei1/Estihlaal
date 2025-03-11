//
//  EditNameViewModel.swift
//  About Us
//
//  Created by Reeman on 10/03/2025.
//This page for enter and save nnew name

import SwiftUI

class EditNameViewModel: ObservableObject {
    @Published var newName: String = ""
    
    func saveName(to profileViewModel: ProfileViewModel) {
        profileViewModel.updateName(to: newName)
    }
}
