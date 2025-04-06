////
////  Untitled.swift
////  Estihlaal
//////
//////  Created by Reem on 11/09/1446 AH.
////import SwiftUI
////
//
import SwiftUI

struct JobDetailsView: View {
    let jobTitle: String
    @ObservedObject var viewModel = JobDetailsViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedSection: String?

    var body: some View {
        VStack {
            HStack {

                Button(action: {
                             presentationMode.wrappedValue.dismiss()
                         }) {
                             Image(systemName: "chevron.left")
                                 .foregroundColor(.white)
                                 .padding()
                         }
                Spacer()
//                Text(jobTitle)
//                    .font(.system(size: 21, weight: .bold))
//                    .foregroundColor(.white)
//                    .padding(.trailing, 109)
                Text(jobTitle)
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Spacer()
                Button(action: {}) {
                       Image(systemName: "chevron.left")
                           .opacity(0) 
                           .padding()
                   }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("main"))
                    .shadow(radius: 5)
                    .padding(.top, -100)

            )

            Group {
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("main")))
                        Text("Loading job details...")
                            .font(.headline)
                            .foregroundColor(Color.gray)
                        Spacer()
                    }
                } else if let details = viewModel.jobDetails {
                    JobDetailsContent(details: details, selectedSection: $selectedSection)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .transition(.opacity)
            .animation(.easeInOut, value: viewModel.isLoading)
            HStack {
                NavigationLink(destination: OverviewPage(viewModel: AssessmentViewModel())) {
                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
                        .padding(.leading)
                }
                
                NavigationLink(destination: Interviews(predictedJobs: [])) {
                    NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
                }
                NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)
                    .padding(.trailing)
            }
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(UIColor.systemGray6))
                    .padding(.bottom, -100)
            )
        }
        .padding(.top, 30)
        .onAppear {
            viewModel.fetchJobDetails(jobTitle: jobTitle)
        }
        .navigationBarBackButtonHidden(true) // ✅ Hides the back button

    }
}



struct JobDetailsContent: View {
    var details: JobDetails
    @Binding var selectedSection: String?

    var body: some View {
        ScrollView {
            ZStack(alignment: .leading) {
                VStack {
                    Spacer(minLength:16)
                    Rectangle()
                        .fill(Color("main"))
                        .frame(width: 4)
                        .frame(maxHeight: .infinity)
                        .offset(x: 23)
                    Spacer(minLength: 10)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    JobDetailRow(title: "Description", content: details.description, selectedSection: $selectedSection)
                    JobDetailRow(title: "Skills", content: details.skills.joined(separator: ", "), selectedSection: $selectedSection)
                    JobDetailRow(title: "Certificates", content: details.certificates.joined(separator: ", "), selectedSection: $selectedSection)
                    JobDetailRow(title: "Salary", content: details.salary, selectedSection: $selectedSection)
                    JobDetailRow(title: "Tools", content: details.tools.joined(separator: ", "), selectedSection: $selectedSection)
                }
                .padding()
            }
            .padding(.top, 20)
        }
    }
}

struct JobDetailRow: View {
    let title: String
    let content: String
    @Binding var selectedSection: String?

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .strokeBorder(Color("main"), lineWidth: 2)
                .background(Circle().fill(selectedSection == title ? Color("main") : Color.white))
                .frame(width: 17, height: 17)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(selectedSection == title ? .white : .black)

                if selectedSection == title {
                    Text(content)
                        .font(.system(size: 18, weight: .regular))
                        .padding(.top, 1)

                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color("main"))
                        .cornerRadius(10)
                        .transition(.opacity)
                        .fixedSize(horizontal: false, vertical: true) // ✅ Expands fully
                } else {
                    Text(content.prefix(100) + (content.count > 100 ? "..." : ""))
                        .font(.body)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation {
                                selectedSection = title
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(selectedSection == title ? Color("main") : Color(.systemGray6))
            .cornerRadius(20)
            .onTapGesture {
                withAnimation {
                    selectedSection = selectedSection == title ? nil : title
                }
            }
        }
    }
}










// Preview Provider
struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(jobTitle: "UI/UX Designer")
            .environmentObject(JobDetailsViewModel())
            .onAppear {
                let sampleDetails = JobDetails(description: "Responsible for creating engaging designs and interfaces for mobile apps. This includes collaborating with cross-functional teams, designing user flows, conducting user research, and prototyping. You'll be responsible for enhancing user experiences on mobile platforms.",
                                               skills: ["Design Thinking", "User Research", "Prototyping"],
                                               certificates: ["Certified UX Designer", "Agile Methodology"],
                                               salary: "$75,000 - $90,000",
                                               tools: ["Sketch", "Figma", "Adobe XD"])
                let viewModel = JobDetailsViewModel()
                viewModel.jobDetails = sampleDetails
            }
    }
}
