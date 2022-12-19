//
//  ChatViewModel.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Published var chats = [Chat]()
    
    @Published var selectedChat: Chat?
    
    @Published var messages = [ChatMessage]()
    
    var databaseService = DatabaseService()
    
    init() {
        // Retrieve chats when ChatViewModel is created
        getCats()
    }
    
    func getCats() {
        // use the database service to retrieve the chats
        databaseService.getAllChats { chats in
            
            // Set the retrieved data to the chats property
            self.chats = chats
        }
        
    }
    
    func getMessages() {
        // Check that there's a selected chat
        
        guard selectedChat != nil else {
            return
        }
            databaseService.getAllMessages(chat: selectedChat!) { msgs in
                self.messages = msgs
            }
        }
    }
