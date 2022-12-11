//
//  SwiftUI_ChatApp.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/9/22.
//

import SwiftUI


@main
struct SwiftUI_ChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(ContactsViewModel())
        }
    }
}
