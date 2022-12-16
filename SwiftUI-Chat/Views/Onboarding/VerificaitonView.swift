//
//  VerificaitonView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI
import Combine

struct VerificaitonView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var verificationCode = ""
    @Binding var isOnboarding: Bool
    
    var body: some View {
        VStack {
            
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            // Textfield
            ZStack {
                
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("", text: $verificationCode)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(verificationCode)) { _ in
                            TextHelper.limitText(&verificationCode, 6)
                        }
                    
                    Spacer()
                    
                    Button {
                        // Clear text field
                        verificationCode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                    
                    
                    
                }
                .padding()
                
            }
            .padding(.top, 34)
            
            Spacer()
            
            Button {
                // Send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    
                    // Check for errors
                    if error == nil {
                        // Check if this user has a profile
                        DatabaseService().checkUserProfile {
                            exists in
                            if exists {
                                // End onboarding
                                isOnboarding = false
                            }
                            else {
                                
                                // Move to the profile creation step
                                currentStep = .profile
                            }
                        }
                        }
                    else {
                        // TODO: Show error message
                    }
                }
                
                
                
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
            
        }
        .padding(.horizontal)
        
    }
}

