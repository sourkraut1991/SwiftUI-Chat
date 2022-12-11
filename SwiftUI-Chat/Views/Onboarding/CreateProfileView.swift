//
//  ProfileView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var firstName = ""
    @State var lastName = ""
    var body: some View {
        VStack {
            
            Text("Setup your profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            Spacer()
        // MARK: Profile Pic
         // Profile image Button
            Button {
                // Show action sheet
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Circle()
                        .stroke(Color("create-profile-boarder"), lineWidth: 2)
                    
                    Image(systemName: "camera.fill")
                        .tint(Color("icons-input"))
                }
                .frame(width: 134, height: 134)
            }
            Spacer()
    
              // First Name
                TextField("First Name", text: $firstName)
                    .textFieldStyle(CreateProfileTextfieldStyle())
                // Last NAME
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(CreateProfileTextfieldStyle())
           
            Spacer()
            
            Button {
                currentStep = .contacts
            } label: {
            Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 82)
        }
        .padding()
    }
}

