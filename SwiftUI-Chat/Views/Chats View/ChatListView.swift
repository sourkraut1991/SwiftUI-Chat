//
//  ChatListView.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var ChatViewModel: ChatViewModel
    var body: some View {
        if ChatViewModel.chats.count > 0 {
            List(ChatViewModel.chats) { chat in
                Text(chat.id ?? "Chat ID")
            }
        }
        else {
            Text("No Chats")
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
