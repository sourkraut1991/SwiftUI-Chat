//
//  AuthViewModel.swift
//  SwiftUI-Chat
//
//  Created by ed on 12/10/22.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    static func logout() {
        try? Auth.auth().signOut()
    }
    
    static func sendPhoneNumber(phone: String,completion: @escaping (Error?) -> Void) {
        
        // Send the phoen number to the firebase Auth
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phone, uiDelegate: nil) { verificationId, error in
                
                if error == nil {
                    UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
                    
                }
                DispatchQueue.main.async {
                    completion(error)
                }
            }
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void ) {
        
        // Get the verification id from local storage
        let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        // Send the code and the verification id to Firebase
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: code
        )
        // Sign in the user
        Auth.auth().signIn(with: credential) { authResult, error in
            
            
        }
    }
}
