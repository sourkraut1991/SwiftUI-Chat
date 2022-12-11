//
//  User.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/11/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    
    var firstname: String
    
    var lastname: String
    
    var phone: String
    
    var photo: String
    
    
}
