//
//  AuthViewModel.swift
//  Speechify
//
//  Created by Fariha Jahin on 12/04/24.
//
 
import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        // Check if user is already logged in when the app starts
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        // Optional: Add a listener to Firebase Auth to ensure persistent login
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            self?.isLoggedIn = user != nil
            UserDefaults.standard.set(user != nil, forKey: "isLoggedIn")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
