//
//  EditNameView.swift
//  About Us
//
//  Created by Reeman on 10/03/2025.
//

import SwiftUI

struct EditNameView: View {
    @ObservedObject var viewModel: EditNameViewModel
    @ObservedObject var profileViewModel: ProfileViewModel

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Back background: lightRed from your extension
            Color.lightRed
                .ignoresSafeArea()
            
            // Front container with mainRed background
            VStack {
                // MARK: - Top Bar
                HStack {
                    // Cancel button in top left (white)
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Title in the center (white)
                    Text("Edit name")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Save button in top right
                    Button(action: {
                        if !viewModel.newName.isEmpty {
                            viewModel.saveName(to: profileViewModel)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(viewModel.newName.isEmpty
                                             ? Color.white.opacity(0.5)
                                             : .white)
                    }
                    .disabled(viewModel.newName.isEmpty)
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                Spacer().frame(height: 50)
                
                // MARK: - Left-Aligned Text Holder & Underline Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Enter New Name")
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    
                    // HStack for the text field and x button
                    HStack {
                        // Text field with placeholder and custom underline
                        ZStack(alignment: .leading) {
                            if viewModel.newName.isEmpty {
                                Text("Your Name")
                                    .foregroundColor(Color.white.opacity(0.7))
                                    .padding(.leading, 5)
                            }
                            TextField("", text: $viewModel.newName)
                                .foregroundColor(.white)
                                .padding(.leading, 5)
                        }
                        // x button appears only if there's text
                        if !viewModel.newName.isEmpty {
                            Button {
                                viewModel.newName = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    // Custom underline (bolder) aligned to the left edge
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 4)
                                .foregroundColor(.white)
                                .cornerRadius(2)
                        },
                        alignment: .bottomLeading
                    )
                }
                .padding(.horizontal)
                .padding(.top, 90)
                
                Spacer()
            }
            .background(Color.mainRed)
        }
    }
}

struct EditNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditNameView(
            viewModel: EditNameViewModel(),
            profileViewModel: ProfileViewModel()
        )
    }
}
