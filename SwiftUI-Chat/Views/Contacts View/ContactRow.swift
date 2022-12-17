//
//  ContactRow.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/16/22.
//

import SwiftUI

struct ContactRow: View {
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    var user: User
    var body: some View {
        HStack (spacing: 24) {
            
            ProfilePicView(user: user)
            
            VStack (alignment: .leading, spacing: 4) {
                // Name
                Text("\(user.firstname ?? "") \(user.lastname ?? "")")
                    .font(Font.button)
                    .foregroundColor(Color("text-primary"))
                
                // Phone number
                Text(user.phone ?? "")
                    .font(Font.bodyParagraph)
                    .foregroundColor(Color("text-input"))
            }
            
            // Extra space
            Spacer()
        }
    }
}
