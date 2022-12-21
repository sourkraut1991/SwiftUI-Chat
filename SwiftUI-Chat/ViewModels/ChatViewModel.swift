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
      
      @Published var selectedChat: Chat?
      
      @Published var messages = [ChatMessage]()
      
      var databaseService = DatabaseService()
      
      init() {
          
          // Retrieve chats when ChatViewModel is created
          getChats()
      }
      
      func getChats() {
          
          // Use the database service to retrieve the chats
          databaseService.getAllChats { chats in
              
              // Set the retrieved data to the chats property
              self.chats = chats
          }
      }
      
      /// Search for chat with passed in user. If found, set as selected chat. If not found, create a new chat
      func getChatFor(contact: User) {
          
          // Check the user
          guard contact.id != nil else {
              return
          }
          
          let foundChat = chats.filter { chat in
              
              return chat.numparticipants == 2 && chat.participantids.contains(contact.id!)
          }
          
          // Found a chat between the user and the contact
          if !foundChat.isEmpty {
              
              // Set as selected chat
              self.selectedChat = foundChat.first!
              
              // Fetch the messages
              getMessages()
          }
          else {
              // No chat was found, create a new one
              var newChat = Chat(id: nil,
                                 numparticipants: 2,
                                 participantids: [AuthViewModel.getLoggedInUserId(), contact.id!],
                                 lastmsg: nil, updated: nil, msgs: nil)
              
              // Set as selected chat
              self.selectedChat = newChat
              
              // Save new chat to the database
              databaseService.createChat(chat: newChat) { docId in
                  
                  // Set doc id from the auto generated document in the database
                  self.selectedChat = Chat(id: docId,
                                           numparticipants: 2,
                                           participantids: [AuthViewModel.getLoggedInUserId(), contact.id!],
                                           lastmsg: nil, updated: nil, msgs: nil)
                  
                  // Add chat to the chat list
                  self.chats.append(self.selectedChat!)
              }
              
              
          }
      }
      
      func getMessages() {
          
          // Check that there's a selected chat
          guard selectedChat != nil else {
              return
          }
          
          databaseService.getAllMessages(chat: selectedChat!) { msgs in
              
              // Set returned messages to property
              self.messages = msgs
          }
          
      }
      
      func sendMessage(msg: String) {
          
          // Check that we have a selected chat
          guard selectedChat != nil else {
              return
          }
          
          databaseService.sendMessage(msg: msg, chat: selectedChat!)
          
      }
    
    func closeConversationViewCleanup() {
        databaseService.detachConversationViewListeners()
    }
    
    func closeChatListViewCleanup() {
        databaseService.detachConversationViewListeners()
    }
      
      // MARK: - Helper Methods
      
      /// Tasks in a list of user ids, removes the user from that list and returns the remaining ids
      func getParticipantIds() -> [String] {
          
          // Check that we have a selected chat
          guard selectedChat != nil else {
              return [String]()
          }
          
          // Filter out the user's id
          let ids = selectedChat!.participantids.filter { id in
              id != AuthViewModel.getLoggedInUserId()
          }
          
          return ids
      }
      
      
  }
