//
//  OnboardingView3.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct WelcomeView: View {
   
    @Binding var currentStep: OnboardingStep 
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding-welcome")
            
            Text("Welcome to Chat App")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Simple and fuss-free chat experience")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            
            Spacer()
            
            Button {
                // Next step
                currentStep = .phonenumber
                
            } label: {
                
                Text("Get Started")
                
            }
            .buttonStyle(OnboardingButtonStyle())
            
            Text("By tapping ‘Get Started’, you agree to our Privacy Policy.")
                .font(Font.smallText)
                .padding(.top, 14)
                .padding(.bottom, 61)

            
        }
        .padding(.horizontal)
        
    }
}

struct OnboardingView3_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(currentStep: .constant(.welcome))
    }
}
