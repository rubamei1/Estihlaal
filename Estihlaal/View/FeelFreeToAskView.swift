import SwiftUI

struct ContactUsView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var selectedSubject: String = "General Inquiry"
    @State private var message: String = ""
    let subjects = ["General Inquiry", "Support", "Feedback", "Other"]
    
    // For dismissing the view (if used within a NavigationView)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
              //Header with Red Background
                ZStack(alignment: .topLeading) {
                    // Full red background
                    Color.mainRed
                        .frame(height: 200)
                        .ignoresSafeArea(edges: .top)
                    
                    // Back button at top left
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    // Centered mail image on top of header
                    HStack {
                        Spacer()
                        Image("wmail")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        Spacer()
                    }
                    .padding(.top, 40)
                }
                .zIndex(1)
                
                // Info Rectangle
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        // "Get in touch"
                        Text("Get in touch")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(Color.mainRed)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        // Name Field
                        TextField("Name", text: $name)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .overlay(
                                Capsule()
                                    .frame(height: 4)
                                    .foregroundColor(Color.lightRed),
                                alignment: .bottom
                            )
                        
                        // Email Field without background
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .overlay(
                                Capsule()
                                    .frame(height: 4)
                                    .foregroundColor(Color.lightRed),
                                alignment: .bottom
                            )
                        
                        // Subject Picker
                        VStack(alignment: .leading) {
                            Text("Subject")
                                .font(.headline)
                            Picker("Subject", selection: $selectedSubject) {
                                ForEach(subjects, id: \.self) { subj in
                                    Text(subj)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            .background(Color(.white))
                            .cornerRadius(8)
                        }
                        
                        // Message Field
                        VStack(alignment: .leading) {
                            Text("Message")
                                .font(.headline)
                            TextEditor(text: $message)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    
                                )
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    
                    // Moving the rectangle upward
                    .offset(y: -60)
                    // Move button
                    .overlay(
                        Button(action: {
                            // Send action here
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background(Color.mainRed)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .offset(y: -20),
                        alignment: .bottom
                    )
                }
                .zIndex(2)
                
                // Social Media Section
                VStack(spacing: 16) {
                    Text("Follow us on")
                        .font(.headline)
                        .foregroundColor(Color.mainRed)
                    
                    HStack(spacing: 30) {
                        
                        Image(systemName:"person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Image(systemName:"person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                //Tab Bar 
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
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
