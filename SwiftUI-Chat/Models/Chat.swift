//
//  Chat.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/18/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    var numparticipants: Int
    
    var participantids: [String]
    
    var lastmsg: String?
    
    @ServerTimestamp var updated:Date?
    
    var msgs: [ChatMessage]?
    
}

struct ChatMessage: Codable, Identifiable {
    
    @DocumentID var id:String?
    
    var imgurl: String?
    
    var msg: String
    
    @ServerTimestamp var timestamp: Date?
    
    var senderid: String
}
