//
//  ContentView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/9/22.
//

import SwiftUI

struct RootView: View {
    
    // For detecting when the app state changes
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @State var selectedTab: Tabs = .contacts
    
    @State var isOnboarding = !AuthViewModel.isUserLoggedIn()
    
    @State var isChatShowing = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                switch selectedTab {
                case .chats:
                    ChatListView(isChatShowing: $isChatShowing)
                case .contacts:
                    ContactsView(isChatShowing: $isChatShowing)
                }
                
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
                
                
            }
            
            .fullScreenCover(isPresented: $isOnboarding) {
                // On Dismiss
            } content: {
                // Onboarding Sequence
                OnboardingView(isOnboarding: $isOnboarding)
            }
            .fullScreenCover(isPresented: $isChatShowing, onDismiss: nil) {
                
                // The conversation view
                ConversationView(isChatShowing: $isChatShowing)
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                    chatViewModel.closeChatListViewCleanup()
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
