//
//  LoginViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import Foundation
import SwiftUI

// LoginViewController to handle logic for the loginView
class LoginViewController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var warning: String = ""
    
    // Logs the given user into the userdatabase by calling the login function of the userdatabase
    func login(userDatabase: UserDatabase, entryDatabase: EntryDatabase, contentViewController: ContentViewController) {
        if self.checkCredentials() {
            if validateEmail() {
                // logs the user into userDatabase
                userDatabase.loginUser(email: email, password: password)
                // lets the application wait a second for the login
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    // Fetches the entries from the database for visualization
                    entryDatabase.getData(user: userDatabase.currentUser)
                    // Navigates to the homePageView by toggling booleans of the contentViewController
                    contentViewController.loginView.toggle()
                    contentViewController.homePageView.toggle()
                }                
            }
            else {
                warning = "email must be a valid email"
            }
            resetInputs()
        }
        else {
            warning = "email and passwort needs to be filled in"
        }
    }
    
    // Checks if the needed credentials are given
    func checkCredentials() -> Bool {
        if password != "" && email != "" {
            return true
        }
        else {
            return false
        }
    }
    
    // Validates the Email against a given regex
    func validateEmail() -> Bool {
        // Quelle: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expression-in-swift
        let range = NSRange(location: 0, length: email.utf16.count)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: emailRegEx)
        
        if regex.firstMatch(in: email, options: [], range: range) != nil {
            return true
        }
        else {
            return false
        }
    }
    
    // Resets the inputs in case the user logs out and gets navigated back to the loginView
    func resetInputs() {
        email = ""
        password = ""
    }
    
    // navigates to the registryView by toggling the booleans of the contentViewController
    func navigateToRegistry(contentViewController: ContentViewController) {
        contentViewController.loginView.toggle()
        contentViewController.registryView.toggle()
    }
}
