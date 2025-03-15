//
//  Untitled.swift
//  EstihlaalVV2
//
//  Created by Reem on 12/09/1446 AH.
//

import SwiftUI
import AVFoundation
import Speech
import Foundation
import SwiftData

// ✅ تعريف نموذج البيانات لحفظ السؤال والإجابة باستخدام SwiftData
@Model
class InterviewResponse {
    var question: String
    var userAnswer: String
    
    init(question: String, userAnswer: String) {
        self.question = question
        self.userAnswer = userAnswer
    }
}


struct ActualInterview: View {
    let selectedPosition: String
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var questionNumber = 1
    let totalQuestions = 5
    @State private var recognizedText: String = ""
    @State private var animationScale: CGFloat = 1.0
    @State private var recordingTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var showRecordingControls = true
    @State private var currentQuestion: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext // ✅ إضافة modelContext لاستخدام SwiftData
    // ✅ تخزين الأسئلة والإجابات لتمريرها إلى InterviewFeedback
        @State private var interviewResponses: [QuestionData] = []

        // ✅ التحكم في عرض صفحة التقييم
        @State private var showFeedback = false
    


    let groqAPIKey = "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"
    let groqEndpoint = "https://api.groq.com/openai/v1/chat/completions"

    var body: some View {
        VStack {
            HStack {
                Text("Interview")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("main"))
                    .padding(.top, -100)
            )

            Spacer().frame(height: 20)

            HStack {
                ForEach(0..<totalQuestions, id: \ .self) { index in
                    Circle()
                        .fill(index < questionNumber ? Color.red : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.leading, 20)

            VStack(alignment: .leading, spacing: 5) {
                Text("Question \(questionNumber)")
                    .font(.system(size: 20))
                    .foregroundColor(.black)

                Text(currentQuestion)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 40)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)

            RoundedRectangle(cornerRadius: 20)
                .fill(Color("req"))
                .frame(width: 360, height: 220)
                .overlay(
                    ScrollView {
                        Text(recognizedText)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                )
                .padding(.top, 0)
                .padding(.horizontal, 20)

            if showRecordingControls {
                ZStack {
                    if audioRecorder.isRecording {
                        ForEach(0..<5, id: \ .self) { i in
                            Circle()
                                .stroke(Color.red.opacity(0.3 - Double(i) * 0.06), lineWidth: 10)
                                .frame(width: 150 + CGFloat(i * 15), height: 150 + CGFloat(i * 15))
                                .scaleEffect(animationScale)
                                .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: animationScale)
                        }
                        Text("Recording...")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .offset(y: -100)
                    }

                    Button(action: {
                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                            timer?.invalidate()
                            saveInterviewResponse()
                            showRecordingControls = false
                        } else {
                            audioRecorder.startRecording { text in
                                                    DispatchQueue.main.async {
                                                    self.recognizedText = text
                                                }
                                                }

                            recordingTime = 0
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                recordingTime += 1
                            }
                        }
                        withAnimation {
                            animationScale = audioRecorder.isRecording ? 1.5 : 1.0
                        }
                    }) {
                        VStack {
                            Circle()
                                .fill(Color("main"))
                                .frame(width: 70, height: 70)
                                .overlay(
                                    Group {
                                        if audioRecorder.isRecording {
                                            Text("STOP")
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.white)
                                        } else {
                                            Image(systemName: "mic.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24, height: 34)
                                                .foregroundColor(.white)
                                        }
                                    }
                                )
                                .shadow(radius: 8)
                        }
                    }
                }
                .padding(.top, 20)
            }

            if !showRecordingControls {
                Button(action: {
                    if questionNumber < totalQuestions {
                        questionNumber += 1
                        recognizedText = ""
                        showRecordingControls = true
                        generateInterviewQuestion()
                    } else {
                        saveInterview()
                        showFeedback = true 
                    }
                }) {
                    Text(questionNumber < totalQuestions ? "Next" : "Done!")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 55)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(questionNumber < totalQuestions ? Color.black : Color("main"))
                        )
                }
                .padding(.top, 20)
        

            }

            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
                    SFSpeechRecognizer.requestAuthorization { status in
                        DispatchQueue.main.async {
                            if status != .authorized {
                                print("❌ Speech recognition authorization denied!")
                            }
                        }
                    }
                    generateInterviewQuestion()
                }
.fullScreenCover(isPresented: $showFeedback) {
            InterviewFeedback(questions: interviewResponses) // ✅ تمرير البيانات إلى صفحة التقييم
        }
    }
    
    func saveInterviewResponse() {
            let response = InterviewResponse(question: currentQuestion, userAnswer: recognizedText)
            modelContext.insert(response)
            
            let questionData = QuestionData(questionText: currentQuestion, userAnswer: recognizedText)
            interviewResponses.append(questionData)
        }

        // ✅ عند انتهاء المقابلة، يتم حفظ البيانات وعرض صفحة التقييم
        func finishInterview() {
            saveInterview()
            showFeedback = true
        }

    func saveInterview() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = formatter.string(from: currentDate)

        var history = UserDefaults.standard.array(forKey: "interviewHistory") as? [[String: String]] ?? []

        if !history.contains(where: { $0["position"] == selectedPosition && $0["date"] == dateString }) {
            history.append(["position": selectedPosition, "date": dateString])
            UserDefaults.standard.set(history, forKey: "interviewHistory")
        }
    }

    func generateInterviewQuestion() {
        let jsonData: [String: Any] = [
            "model": "llama-3.3-70b-versatile",
            "messages": [
                ["role": "system", "content": "You generate concise interview questions for the position \(selectedPosition). The question should be direct and within three lines."],
                ["role": "user", "content": "Generate a clear and concise interview question for \(selectedPosition). No introductory text or explanations, just the question itself."]
            ],
            "max_tokens": 50
        ]

        guard let url = URL(string: groqEndpoint),
              let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
            DispatchQueue.main.async {
                self.currentQuestion = "❌ ERROR: Invalid API request"
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(groqAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data,
               let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = jsonResponse["choices"] as? [[String: Any]],
               let firstChoice = choices.first,
               let message = firstChoice["message"] as? [String: Any],
               let text = message["content"] as? String {
                DispatchQueue.main.async {
                    self.currentQuestion = text.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            } else {
                DispatchQueue.main.async {
                    self.currentQuestion = "❌ ERROR: Failed to fetch question"
                }
            }
        }.resume()
    }
    
    class AudioRecorder: NSObject, ObservableObject {
        var audioEngine = AVAudioEngine()
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        @Published var isRecording = false

        func startRecording(completion: @escaping (String) -> Void) {
            isRecording = true
            recognitionTask?.cancel()
            recognitionTask = nil
            
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            recognitionRequest.shouldReportPartialResults = true

            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            audioEngine.prepare()
            try? audioEngine.start()

            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    DispatchQueue.main.async {
                        completion(result.bestTranscription.formattedString)
                    }
                }
                if error != nil {
                    self.stopRecording()
                }
            }
        }

        func stopRecording() {
            DispatchQueue.main.async {
                        self.isRecording = false
                    }
                    isRecording = false
                    audioEngine.stop()
                    audioEngine.inputNode.removeTap(onBus: 0)
                    recognitionRequest?.endAudio()
                    recognitionTask?.cancel()
                    recognitionRequest = nil
                    recognitionTask = nil
        }
    }
}

#Preview {
   ActualInterview(selectedPosition: "UI/UX Designer")
}
