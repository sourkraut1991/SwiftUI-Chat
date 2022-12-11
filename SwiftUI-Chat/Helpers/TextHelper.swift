//
//  TextHelper.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/11/22.
//

import Foundation


class TextHelper {
    static func sanitizePhoneNumber(_ phone: String) -> String {
        return phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
}
