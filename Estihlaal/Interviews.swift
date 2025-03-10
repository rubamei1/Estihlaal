//
//  Interviews.swift
//  Estihlaal
//
//  Created by Aliah Alhameed on 10/09/1446 AH.
//

import SwiftUI

struct Interviews: View {
    @State private var selectedTab = "Take an interview"
    @State private var interviewHistory: [[String: String]] = []

    let positions = ["UI/UX Designer", "Graphic Designer", "Product Designer", "UX Researcher"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Interviews")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.systemGray6))
                        .padding(.top, -100)
                )

                Spacer().frame(height: 20)

                // Tabs
                HStack {
                    Button(action: { selectedTab = "Take an interview" }) {
                        Text("Take an interview")
                            .font(.system(size: 16))
                            .fontWeight(selectedTab == "Take an interview" ? .bold : .regular)
                            .foregroundColor(.black)
                    }
                    .overlay(
                        Rectangle()
                            .fill(Color("main"))
                            .frame(height: 5)
                            .offset(y: 25)
                            .opacity(selectedTab == "Take an interview" ? 1 : 0)
                    )

                    Spacer()

                    Button(action: { selectedTab = "Interviews history" }) {
                        Text("Interviews history")
                            .font(.system(size: 16))
                            .fontWeight(selectedTab == "Interviews history" ? .bold : .regular)
                            .foregroundColor(.black)
                    }
                    .overlay(
                        Rectangle()
                            .fill(Color("main"))
                            .frame(height: 5)
                            .offset(y: 25)
                            .opacity(selectedTab == "Interviews history" ? 1 : 0)
                    )
                }
                .padding(.horizontal, 40)

                VStack {
                    if selectedTab == "Interviews history" {
                        if interviewHistory.isEmpty {
                            Spacer()
                            Text("You haven’t taken any interview")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Spacer()
                        } else {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(interviewHistory, id: \.self) { interview in
                                        HStack {
                                            // ✅ عرض الوظيفة على اليسار
                                            Text(interview["position"] ?? "Unknown Position")
                                                .font(.system(size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)

                                            Spacer()

                                            // ✅ عرض التاريخ والوقت بشكل عمودي (التاريخ في الأعلى، الوقت تحته)
                                            VStack(alignment: .trailing) {
                                                Text(formatDate(dateString: interview["date"] ?? ""))
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)

                                                Text(formatTime(dateString: interview["date"] ?? ""))
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding()
                                        .frame(width: 350, height: 70)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color("main"), lineWidth: 2)
                                        )
                                    }
                                }
                                .padding(.top, 20)
                            }
                            .background(Color.white)
                        }
                    } else {
                        Text("What position you're interviewing for?")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.top, 50)

                        VStack(spacing: 16) {
                            ForEach(positions, id: \.self) { position in
                                NavigationLink(destination: ActualInterview(selectedPosition: position)) {
                                    Text(position)
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                        .frame(width: 375, height: 80)
                                        .background(Color("main"))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)

                Spacer()

                // ✅ شريط التنقل (Navigation Bar)
                HStack {
                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: false)
                        .padding(.leading)
                    NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: true)
                    NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)
                        .padding(.trailing)
                }
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(UIColor.systemGray6))
                        //.padding(.top, -10)
                        .padding(.bottom, -100)
                )
            }
            .padding(.top)
            .background(Color.white)
            .onAppear {
                loadInterviews()
            }
        }
    }

    // ✅ تحميل البيانات مع إزالة التكرارات
    func loadInterviews() {
        var history = UserDefaults.standard.array(forKey: "interviewHistory") as? [[String: String]] ?? []
        history = removeDuplicates(from: history)
        interviewHistory = history
        UserDefaults.standard.set(history, forKey: "interviewHistory")
    }

    // ✅ إزالة المقابلات المكررة بناءً على الوظيفة + التاريخ + الوقت
    func removeDuplicates(from history: [[String: String]]) -> [[String: String]] {
        var uniqueInterviews: [[String: String]] = []
        for interview in history {
            if !uniqueInterviews.contains(where: { $0["position"] == interview["position"] && $0["date"] == interview["date"] }) {
                uniqueInterviews.append(interview)
            }
        }
        return uniqueInterviews
    }

    // ✅ دالة لتنسيق التاريخ ليظهر بصيغة "Monday 17 February"
    func formatDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: dateString) else { return "Unknown Date" }

        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: date)
    }

    // ✅ دالة لتنسيق الوقت ليظهر بشكل صحيح أسفل التاريخ
    func formatTime(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: dateString) else { return "Unknown Time" }

        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// ✅ مكون `NavItem` لشريط التنقل
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

#Preview {
    Interviews()
}
