//
//  OverviewPage.swift
//  Estihlaal
//
//  Created by Maryam Amer Bin Siddique on 05/09/1446 AH.
//

import SwiftUICore
import SwiftUI

struct OverviewPage: View {
    @ObservedObject var viewModel: AssessmentViewModel
    var userName: String = "User"
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text(userName)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                        
                        Text("👋")
                            .font(.title)
                    }
                    .padding(.bottom, -20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 110)
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.systemGray6)).padding(.top, -30)
                )
                
                Text("Discover your Career path!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 30)
                    .padding(.leading, 10)
                
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("main"))
                        .shadow(color:Color("main").opacity(0.5), radius: 0, x: 0, y: 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Career path")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.leading)
                        
                        Text("We’re going to help you figure out your optimal path towards success. Take this short assessment and you’ll be good to go!")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack {
                            NavigationLink(destination: AssessmentQ1(viewModel: viewModel)) {
                                Text("Start")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                    .foregroundColor(.black)
                                    .shadow(color: .white.opacity(0.5), radius: 0, x: 0, y: 5)
                            }
                            .padding(.top, 160)
                            .padding(.horizontal, 25)
                            .padding(.trailing, 1)
                            
                            Spacer()
                            
                            Image("directions")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 240)
                            //                            .padding(.bottom, 10)
                                .padding(.trailing, 25)
                        }
                        .padding(.top, -25)
                    }
                    .padding()
                }
                .frame(height: 220)
                .padding(.horizontal)
                .padding(.top ,80)
                
                
                Spacer()
                
                // Navigation Bar
                HStack {
                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
                        .padding(.leading)
                    NavigationLink(destination: Interviews(predictedJobs: [])) { // ✅ Linked to Interviews page
                        NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
                    }
                    NavigationLink(destination: ProfileView(userName: userName)) {
                        NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)
                    }
                }
                .frame(height: 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.systemGray6))
                        .padding(.bottom, -100).padding(.top, -30)
                )
                .padding(.bottom, 40)
            }
            .padding(.top)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct NavItem: View {
    let icon: String
    let text: String
    let isActive: Bool
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isActive ? Color("main") : Color("accent"))
            
            Text(text)
                .font(.caption)
                .foregroundColor(isActive ? Color("main") : Color("accent"))
        }
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    OverviewPage()
//}
