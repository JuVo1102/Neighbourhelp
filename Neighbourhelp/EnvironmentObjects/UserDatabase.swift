//
//  UserDatabase.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import FirebaseAuth

// Quellen: 1. https://firebase.google.com/docs/auth/ios/start am 02.07.2021
//         2. https://stackoverflow.com/questions/66486840/how-to-signout-user-from-console-in-swift

// Firebase authentication-service

class UserDatabase: ObservableObject {
    @Published var currentUser: User = User(email: "dummyData", password: "dummyData")
        
    // Adds a new user to the firebase-database
    func AddUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email.lowercased(), password: password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                self.currentUser = User(email: email, password: password)
            }
        }
    }
    
    // Logs the user into the firebase-authentication
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)                
            }
            else {
                self.currentUser = User(email: email, password: password)
            }
        }
    }
    
    // Logs the user out of the firebase-authentication
    func logout() {
        do {
            try Auth.auth().signOut()
            currentUser.email = ""
            currentUser.password = ""
        }
        catch {
            print(error)
        }
    }
}
