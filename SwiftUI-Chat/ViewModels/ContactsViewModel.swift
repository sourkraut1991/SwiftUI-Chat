//
//  ContactsViewModel.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import Foundation
import Contacts

class ContactsViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        DispatchQueue.init(label: "get contacts").async {
            do {
                // Ask for Permission
                let store = CNContactStore()
                
                // List of keys we wantt o get
                let keys = [CNContactPhoneNumbersKey, CNContactPhoneticGivenNameKey,
                            CNContactFamilyNameKey] as [CNKeyDescriptor]
                
                // Create a Fetch request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                // get the contacts on users phone
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
                    // Do something with contact
                    self.localContacts.append(contact)
                })
                
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    
                   //Update the UI in the main thread
                    DispatchQueue.main.async {
                        // Set the fetched users to the published users property
                        self.users = platformUsers
                    }
            
                    
                    
                }
                
            }
            catch {
                // Handle error
//                return error
            }
        }
    }
}
