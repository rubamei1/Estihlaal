//
//  ActualInterview.swift
//  Estihlaal
//
//  Created by Aliah Alhameed on 10/09/1446 AH.
//
import SwiftUI
import AVFoundation
import Speech

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
    @Environment(\.presentationMode) var presentationMode

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
                ForEach(0..<totalQuestions, id: \.self) { index in
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

                Text("What is your major?")
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
                        ForEach(0..<5, id: \.self) { i in
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
                            showRecordingControls = false
                        } else {
                            audioRecorder.startRecording { text in
                                self.recognizedText = text
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
                    } else {
                        saveInterview() // ✅ حفظ بدون تكرار
                        presentationMode.wrappedValue.dismiss()
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
    }

    // ✅ تحسين دالة الحفظ بحيث لا تحفظ المقابلة إذا كانت مسجلة مسبقًا بنفس الوظيفة + التاريخ + الوقت
    func saveInterview() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = formatter.string(from: currentDate)

        var history = UserDefaults.standard.array(forKey: "interviewHistory") as? [[String: String]] ?? []

        // ✅ التحقق مما إذا كانت نفس الوظيفة + التاريخ + الوقت محفوظة مسبقًا قبل الإضافة
        if !history.contains(where: { $0["position"] == selectedPosition && $0["date"] == dateString }) {
            history.append(["position": selectedPosition, "date": dateString])
            UserDefaults.standard.set(history, forKey: "interviewHistory")
        }
    }
}

// ✅ كلاس `AudioRecorder` لمعالجة تسجيل الصوت
class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder?
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    @Published var isRecording = false

    func startRecording(completion: @escaping (String) -> Void) {
        isRecording = true
        completion("Example recognized text") // ✅ محاكاة تحليل الصوت
    }

    func stopRecording() {
        isRecording = false
    }
}

#Preview {
    ActualInterview(selectedPosition: "UI/UX Designer") // ✅ تم تمرير الوظيفة المختارة
}

