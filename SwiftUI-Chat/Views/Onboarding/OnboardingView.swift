//
//  OnboardingView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

enum OnboardingStep: Int {
    case welcome = 0
    case phonenumber = 1
    case verification = 2
    case profile = 3
    case contacts = 4
    
}


struct OnboardingView: View {
    @Binding var isOnboarding: Bool
    @State var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea(edges: [.top, .bottom])
            
            switch currentStep {
            case .welcome: WelcomeView(currentStep: $currentStep)
            case .phonenumber: PhoneNumberView(currentStep: $currentStep)
            case .verification: VerificaitonView(currentStep: $currentStep, isOnboarding: $isOnboarding)
            case .profile: CreateProfileView(currentStep: $currentStep)
            case .contacts: SyncContactsView(isOnboarding: $isOnboarding)
            }
        }
    }
}

