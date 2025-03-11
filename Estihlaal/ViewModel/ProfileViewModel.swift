//
//  ProfileViewModel.swift
//  About Us
//
//  Created by Reeman on 10/03/2025.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User = User(name: "Aliah ")) {
        self.user = user
    }
    
    func updateName(to newName: String) {
        user.name = newName
    }
}
