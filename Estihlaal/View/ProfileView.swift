//
//  ProfileView.swift
//  About Us
//
//  Created by Reeman on 10/03/2025.
//

import SwiftUI

// Custom shape for rounding only the bottom corners
//struct RoundedCornerShape: Shape {
//    var corners: UIRectCorner
//    var radius: CGFloat
//    
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(
//            roundedRect: rect,
//            byRoundingCorners: corners,
//            cornerRadii: CGSize(width: radius, height: radius)
//        )
//        return Path(path.cgPath)
//    }
//}

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var showEditSheet = false  // <-- Add this state var
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Red header Part
                ZStack {
                    RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 25)
                        .fill(Color.mainRed)
                        .ignoresSafeArea(edges: .top)
                    
                    HStack {
                        Text(viewModel.user.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        // Pencil icon
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
                
                // Main content
                VStack(alignment: .leading, spacing: 16) {
                    Text("About us")
                        .font(.headline)
                        .padding(.leading, 10)
                    
                    Text("""
                         determent career path, we’re going to help you figure out your optimal path towards success. take this short assessment
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
                
                // Tab bar
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "briefcase.fill")
                        Text("Career path")
                            .font(.caption2)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Interviews")
                            .font(.caption2)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("More")
                            .font(.caption2)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.2)),
                    alignment: .top
                )
            }
            .navigationBarHidden(true)
            //  a sheet
            .sheet(isPresented: $showEditSheet) {
                // Pass the same ViewModels as before
                EditNameView(
                    viewModel: EditNameViewModel(),
                    profileViewModel: viewModel
                )
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
