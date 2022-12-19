//
//  ChatViewModel.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var chats = [Chat]()
    
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
}
