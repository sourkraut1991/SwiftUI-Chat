//
//  ContentView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/9/22.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Tabs = .contacts
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Spacer()
            CustomTabBar(selectedTab: $selectedTab)
            
        }
        .fullScreenCover(isPresented: $isOnboarding) {
            // On Dismiss
        } content: {
            // Onboarding Sequence
          OnboardingView(isOnboarding: $isOnboarding)
        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
