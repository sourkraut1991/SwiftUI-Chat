//
//  ChatListView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct ChatListView: View {
    
    @EnvironmentObject var ChatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    
    var body: some View {
        if ChatViewModel.chats.count > 0 {
            List(ChatViewModel.chats) { chat in
               
                Button {
                    // Set selected chat for the chatviewmodel
                    ChatViewModel.selectedChat = chat
                    //display conversation view
                    isChatShowing = true
                    
                } label: {
                    Text(chat.id ?? "Chat ID")
                }

                
            }
        }
        else {
            Text("No Chats")
        }
    }
}

