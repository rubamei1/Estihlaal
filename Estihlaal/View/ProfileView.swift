//
//  ProfileView.swift
//  About Us
//
//  Created by Reeman on 10/03/2025.
//

import SwiftUI
struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @State private var showEditSheet = false

    init(userName: String) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(user: User(name: userName)))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Red header
                ZStack {
                    RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 25)
                        .fill(Color.mainRed)
                        .ignoresSafeArea(edges: .top)

                    HStack {
                        Text(viewModel.user.name) // ✅ Real interpolated username
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 10)

                        Spacer()

                        Button {
                            showEditSheet = true
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                }
                .frame(height: 100)

                Spacer().frame(height: 20)

                // Main content stays unchanged
                VStack(alignment: .leading, spacing: 16) {
                    Text("About us")
                        .font(.headline)
                        .padding(.leading, 10)

                    Text("""
                         Estihlaal – Your Career Success Partner.
                         We are dedicated to help job-seeking graduates find the perfect career path through our personalized assessments and our AI-powered interview simulator.
                         """)
                        .font(.body)
                        .padding(.leading, 10)

                    // Contact US
                    HStack {
                        Spacer()
                        HStack(spacing: 8) {
                            Image(systemName: "headset")
                                .foregroundColor(.mainRed)

                            Text("Feel free to Ask, we ready to help")
                                .font(.subheadline)
                                .foregroundColor(.mainRed)
                        }
                        .padding()
                        .background(Color.lightRed)
                        .cornerRadius(8)
                        .padding(.top, 300)
                        Spacer()
                    }

                    Spacer()
                }
                .padding()
                .padding(.top, 50)

                // Navigation Bar
                HStack {
                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: false)
                        .padding(.leading)
                    NavigationLink(destination: Interviews(predictedJobs: [])) { // ✅ Linked to Interviews page
                        NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
                    }
                    NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: true)
                }
                .frame(height: 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.systemGray6))
                        .padding(.bottom, -100).padding(.top, -30)
                )
                .padding(.bottom, 40)
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showEditSheet) {
                EditNameView(
                    viewModel: EditNameViewModel(),
                    profileViewModel: viewModel
                )
            }
        }
    }
}
