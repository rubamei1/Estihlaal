//
//  ContentView.swift
//  EstehlalRee
//
//  Created by Reeman on 03/03/2025.
//

import SwiftUI

struct InterviewFeedback: View {
    @State private var currentQuestion = 1
    let totalQuestions = 6
    
    var body: some View {
        VStack(spacing: 1) {
            // Header
            headerView
            
            // Question Bar
            questionIndicatorView
            
            // Scroll View
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    feedbackSection(title: "Precision of the answer", content: "Answer Here")
                    
                    feedbackSection(title: "Confidence and quality of speech")
                    
                    feedbackSection(title: "Tips and ideal answer")
                }
                .padding(.horizontal, 16)
                .padding(.top, 1)
                .padding(.bottom, 40)
            }
            
            // Tab Bar
            tabBarView
        }
        .background(Color.white)
    }
    
    // Header
    private var headerView: some View {
        ZStack {
            Color(red: 1, green: 0.32, blue: 0.34)
                .edgesIgnoringSafeArea(.top)
                
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { /* الرجوع */ }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    Text("Interview Feedback")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                .padding(.top, 19)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("UI/UX Designer")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Monday 17 February")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        Text("20:30")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                    .offset(y: 9)
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
        }
        .frame(height: 200)
        .clipShape(
            RoundedCornerShape(corners: [.bottomLeft, .bottomRight], radius: 30)
        )
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // Question Bar
    private var questionIndicatorView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                // مؤشر الدوائر
                HStack(spacing: 4) {
                    ForEach(1...totalQuestions, id: \.self) { index in
                        Circle()
                            .fill(index == currentQuestion ? Color.red : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Question \(currentQuestion)")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundColor(.black)
                    Text("What is your major ?")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: { /* الإجابة */ }) {
                    Text("Your answer")
                        .font(.system(size: 14).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color(red: 1, green: 0.32, blue: 0.34))
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .offset(y: -10)
        }
        .offset(y: -40)
    }
    
    // Feedback
    private func feedbackSection(title: String, content: String = "") -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16).weight(.bold))
                .foregroundColor(.black)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(white: 0.94))
                .frame(height: 180)
                .overlay(
                    Text(content)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(),
                    alignment: .topLeading
                )
        }
    }
    
    // Tab Bar
    private var tabBarView: some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                Image(systemName: "briefcase.fill")
                Text("Career path")
                    .font(.system(size: 13).weight(.bold))
                    .foregroundColor(.black)
            }
            Spacer()
            VStack(spacing: 4) {
                Image(systemName: "person.fill")
                    .foregroundColor(Color(red: 1, green: 0.32, blue: 0.34))
                Text("Interviews")
                    .font(.system(size: 13).weight(.bold))
                    .foregroundColor(Color(red: 1, green: 0.32, blue: 0.34))
            }
            Spacer()
            VStack(spacing: 4) {
                Image(systemName: "square.grid.2x2.fill")
                Text("More")
                    .font(.system(size: 13).weight(.bold))
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.trailing, 16)
        .background(Color.white)
    }
}


#Preview {
    InterviewFeedback()
}
