////
////  Estihlaal
////
////  Created by Reem on 11/09/1446 AH.
////
import SwiftUI

struct JobPositionsView: View {
    let field: String
    let major: String
    let interests: [String]
    let skills: [String]
    let predictedJobs: [String]

    var body: some View {
        VStack {
            // Header area
            VStack {
                Text("Positions")
                    .font(.system(size: 24, weight: .semibold))                 .padding(.top, 70)
                    .padding(.bottom, 60)

                Text("Click position to show position details")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)

            if predictedJobs.isEmpty {
                ProgressView("Fetching jobs...")
                    .font(.system(size: 18))

                    .scaleEffect(2)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(predictedJobs, id: \.self) { job in
                            NavigationLink(destination: JobDetailsView(jobTitle: job)) {
                                Text(job)
                                    .font(.system(size: 19, weight: .bold))
                                    .frame(width: 120, height:170)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("main"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(color:Color("main").opacity(0.5), radius: 0, x: 10, y: 0)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5) //                             
                      

                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            HStack {
                NavigationLink(destination: OverviewPage(viewModel: AssessmentViewModel())) {
                    NavItem(icon: "briefcase.fill", text: "Career path", isActive: true)
                        .padding(.leading)
                }

                NavigationLink(destination: Interviews(predictedJobs: predictedJobs)) {
                    NavItem(icon: "person.2.wave.2.fill", text: "Interviews", isActive: false)
                }



                NavItem(icon: "square.grid.2x2.fill", text: "More", isActive: false)
            }
            .padding(.bottom)
            .frame(height: 90)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(UIColor.systemGray6))
                    .padding(.bottom, -10).padding(.top, -2)
            )



        }
        .background(Color(.white))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)

    }
}

struct JobPositionsView_Previews: PreviewProvider {
    static var previews: some View {
        JobPositionsView(
            field: "Technology",
            major: "UX Design",
            interests: ["User Interface", "User Experience"],
            skills: ["Sketch", "Figma"],
            predictedJobs: ["UI/UX Designer", "Product Designer", "Graphic Designer", "UI Designer"]
        )
    }
}


