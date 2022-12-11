//
//  DatabaseService.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/11/22.
//

import Foundation
import Contacts
import Firebase

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping([User]) -> Void) {
        
        // The array where we're storing fetched platform users
        var platformUsers = [User]()
        
        
        // Construct an array of string phone numbers to look up
        var lookupPhoneNumbers =   localContacts.map { contact in
            
            // Turn the contact into a phone number as a string
            return TextHelper.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
            
            
        }
        
        guard lookupPhoneNumbers.count > 0 else {
            completion(platformUsers)
            return
        }
        
        
        
        // Perform queries hwile we still have phone numbers to look up
        while !lookupPhoneNumbers.isEmpty {
            
            // Query the database for these phone numbers
            let db = Firestore.firestore()
            
            // Get the first 10 phonenumbers to look up
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            
            // Remove the < 10 that we're lookign up
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            // look up the first 10
            let query = db.collection("users").whereField("phone", in: lookupPhoneNumbers)
            
            // Retrieve the users that are on the platform
            query.getDocuments { snapshot, error in
                
                // check for errors
                if error == nil && snapshot != nil {
                    
                    // For each doc that was fetched, create a user
                    for doc in snapshot!.documents {
                        
                        if let user = try? doc.data(as: User.self) {
                            // Append to the platform users array
                            platformUsers.append(user)
                        }
                    }
                    // Check if we have anymore phone numbers to look up
                    // If not, we can call the copmpletion block and we're done
                    if lookupPhoneNumbers.isEmpty {
                        // Return these users
                        completion(platformUsers)
                    }
                    
                }
            }
        }
        
    }
}
