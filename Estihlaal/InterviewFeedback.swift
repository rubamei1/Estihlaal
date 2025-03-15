//
//  InterviewFeedback.swift
//  EstihlaalVV2
//
//  Created by Aliah Alhameed on 13/09/1446 AH.
//

import SwiftUI
import Foundation

// ✅ تعريف API KEY والرابط
let groqAPIKey = "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"
let groqEndpoint = "https://api.groq.com/openai/v1/chat/completions"

// ✅ نموذج البيانات للأسئلة وإجابات المستخدم
struct QuestionData: Identifiable {
    let id = UUID()
    let questionText: String
    var userAnswer: String // ✅ تحديثه ليكون متغيرًا
}

// ✅ نموذج بيانات تحليل الإجابة من API
struct FeedbackResponse: Codable {
    let precision: String
    let confidence: String
    let tips: String
}

struct InterviewFeedback: View {
    let questions: [QuestionData] // ✅ استلام قائمة الأسئلة والإجابات من `ActualInterview`
    @State private var feedbackResults: [UUID: FeedbackResponse] = [:] // ✅ تخزين نتائج التحليل لكل سؤال
    @State private var currentQuestion = 1
    @State private var showAnswerSheet = false

    var totalQuestions: Int {
        questions.count
    }

    var body: some View {
        VStack(spacing: 1) {
            headerView
            
            VStack(spacing: 0) {
                questionIndicatorView
                
                TabView(selection: $currentQuestion) {
                    ForEach(questions.indices, id: \ .self) { index in
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 24) {
                                feedbackSection(title: "Precision of the answer", content: feedbackResults[questions[index].id]?.precision ?? "Analyzing...")
                                feedbackSection(title: "Confidence and quality of speech", content: feedbackResults[questions[index].id]?.confidence ?? "Analyzing...")
                                feedbackSection(title: "Tips and ideal answer", content: feedbackResults[questions[index].id]?.tips ?? "Analyzing...")
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 1)
                            .padding(.bottom, 40)
                        }
                        .tag(index + 1)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentQuestion)
            }
            
            tabBarView
        }
        .background(Color.white)
        .onAppear {
            fetchFeedbackForAllQuestions()
        }
    }
    
    private var headerView: some View {
        ZStack {
            Color("main").edgesIgnoringSafeArea(.top)
            VStack(alignment: .leading) {
                HStack {
                    Text("Interview Feedback")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                .padding(.top, 19)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Interview Analysis")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private var questionIndicatorView: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(1...totalQuestions, id: \ .self) { index in
                    Circle()
                        .fill(index == currentQuestion ? Color.red : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Question \(currentQuestion)")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundColor(.black)
                    
                    Text(questions[currentQuestion - 1].questionText)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .frame(height: 40, alignment: .topLeading)
                        .lineLimit(2)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .offset(y: -10)
        }
        .offset(y: -40)
    }
    
    private func feedbackSection(title: String, content: String) -> some View {
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
    
    private var tabBarView: some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                Image(systemName: "person.fill")
                    .foregroundColor(Color.red)
                Text("Interviews")
                    .font(.system(size: 13).weight(.bold))
                    .foregroundColor(Color.red)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    private func fetchFeedbackForAllQuestions() {
        for question in questions {
            fetchFeedback(for: question)
        }
    }
    
    private func fetchFeedback(for question: QuestionData) {
            guard !question.userAnswer.isEmpty else {
                print("❌ ERROR: No user answer provided")
                return
            }
            
            let jsonData: [String: Any] = [
                "model": "llama-3.3-70b-versatile",
                "messages": [
                               ["role": "system", "content": """
                                   You are an AI interview evaluator. Evaluate the user's response based on these criteria:
                                   
                                   1️⃣ **Precision of the Answer**: Analyze answer accuracy in **4 concise lines**, focusing on relevance and completeness.
                                   
                                   2️⃣ **Confidence and Quality of Speech**: Evaluate fluency and provide at least **two improvement tips** (e.g., "Avoid hesitation", "Structure your thoughts clearly").
                                   
                                   3️⃣ **Tips and Ideal Answer**: Provide a **5-line ideal response** to this interview question.
                                   
                                   Return a clear and structured response for each section.
                               """],
                               ["role": "user", "content": """
                                   **Interview Question:** \(question.questionText)
                                   **User's Answer:** \(question.userAnswer)
                                   
                                   Evaluate the response based on the three requested criteria.
                               """]
                           ],
                           "max_tokens": 400
            ]
            
            guard let url = URL(string: groqEndpoint),
                  let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
                print("❌ ERROR: Invalid API request")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer \(groqAPIKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("❌ ERROR: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.feedbackResults[question.id] = FeedbackResponse(
                            precision: "Failed to fetch analysis",
                            confidence: "Try again later",
                            tips: "No suggestions available"
                        )
                    }
                    return
                }
                
                guard let data = data else {
                    print("❌ ERROR: No data received")
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print("📩 RAW RESPONSE: \(jsonResponse ?? [:])") // ✅ طباعة الاستجابة لتصحيح الأخطاء
                    
                    if let choices = jsonResponse?["choices"] as? [[String: Any]],
                       let message = choices.first?["message"] as? [String: Any],
                       let text = message["content"] as? String {
                        
                        let feedback = FeedbackResponse(
                            precision: text,
                            confidence: "Confidence analysis not available",
                            tips: "Consider structuring your answer better."
                        )
                        DispatchQueue.main.async {
                            self.feedbackResults[question.id] = feedback
                        }
                    } else {
                        print("❌ ERROR: Unexpected API response format")
                    }
                } catch {
                    print("❌ ERROR: Failed to parse JSON - \(error.localizedDescription)")
                }
            }.resume()
        }

}


#Preview {
    InterviewFeedback(questions: [
        QuestionData(questionText: "What is your major?", userAnswer: "Computer Science"),
        QuestionData(questionText: "Tell me about yourself", userAnswer: "I love design...")
    ])
}
