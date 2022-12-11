//
//  SyncContactsView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct SyncContactsView: View {
    
    @Binding var isOnboarding: Bool
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("onboarding-all-set")
            
            Text("Awesome!")
                .font(Font.titleText)
                .padding(.top, 32)
            
            Text("Continue tio start chatting with your frields")
                .font(Font.bodyParagraph)
                .padding(.top, 8)
            
            
            Spacer()
            
            Button {
             // end Onboarding
                
                isOnboarding = false
            } label: {
                
                Text("Continue")
                
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            
           
        }
        .padding(.horizontal)
        .onAppear {
            
            // Get local contacts
            contactsViewModel.getLocalContacts()
        }
    }
}

