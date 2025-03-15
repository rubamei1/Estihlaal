//////
//////  interview.swift
//////  EstihlaalVV2
//////
//////  Created by Reem on 12/09/1446 AH.
//////
////
//

import SwiftUI

struct Interviews: View {
    @State private var selectedTab = "Take an interview"
    @State private var interviewHistory: [[String: String]] = []
    var userName: String = "User"

    let predictedJobs: [String] // ✅ Receive predicted jobs directly

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // ✅ Header Styling
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

                // ✅ Tabs for switching between Interview & History
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
                                            Text(interview["position"] ?? "Unknown Position")
                                                .font(.system(size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)

                                            Spacer()

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
                        // ✅ "Take an Interview" Section
                        Text("What position you’re interviewing for?")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.top, 20)

                        if predictedJobs.isEmpty {
                            Text("No jobs available.")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(predictedJobs, id: \.self) { position in
                                        NavigationLink(destination: ActualInterview(selectedPosition: position)) {
                                            Text(position)
                                                .font(.system(size: 18))
                                                .fontWeight(.bold)
                                                .frame(width: 350, height: 80)
                                                .background(Color("main"))
                                                .foregroundColor(.white)
                                                .cornerRadius(15)
                                                .shadow(color: Color("main").opacity(0.5), radius: 5, x: 5, y: 5)
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 10)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)

                Spacer()

                // ✅ Bottom Navigation Bar
                HStack {
                    NavigationLink(destination: OverviewPage(viewModel: AssessmentViewModel())) {
                        NavItem(icon: "briefcase.fill", text: "Career path", isActive: false)
                            .padding(.leading)
                    }
                    NavigationLink(destination: Interviews(predictedJobs: [])) {
                        NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: true)
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
            .background(Color.white)
            .onAppear {
                loadInterviews()
            }
        }
        .navigationBarBackButtonHidden(true)

    }

    // ✅ Load interview history
    func loadInterviews() {
        var history = UserDefaults.standard.array(forKey: "interviewHistory") as? [[String: String]] ?? []
        history = removeDuplicates(from: history)
        interviewHistory = history
        UserDefaults.standard.set(history, forKey: "interviewHistory")
    }

    // ✅ Remove duplicates
    func removeDuplicates(from history: [[String: String]]) -> [[String: String]] {
        var uniqueInterviews: [[String: String]] = []
        for interview in history {
            if !uniqueInterviews.contains(where: { $0["position"] == interview["position"] && $0["date"] == interview["date"] }) {
                uniqueInterviews.append(interview)
            }
        }
        return uniqueInterviews
    }

    // ✅ Format date function
    func formatDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: dateString) else { return "Unknown Date" }

        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: date)
    }

    // ✅ Format time function
    func formatTime(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: dateString) else { return "Unknown Time" }

        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// ✅ Navigation Bar Item Component
struct NavItemm: View {
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
    Interviews(predictedJobs: ["UI/UX Designer", "Graphic Designer", "Product Designer", "UX Researcher"])
}
