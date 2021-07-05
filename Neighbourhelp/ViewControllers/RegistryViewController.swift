//
//  RegistryViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import SwiftUI

// Quelle: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expression-in-swift

// RegistryViewController to handle the logic for the registryView
class RegistryViewController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var warning: String = ""
    
    // Registers a new user to the userDatabase by calling the addUser function of the userDatabase
    func register(userdataBase: UserDatabase, entryDatabase: EntryDatabase, contentViewController: ContentViewController) {
        if validateCredentials() {
            if validatePassword(){
                if validateEmail() {
                    // Adds a user to the dataBase
                    userdataBase.AddUser(email: email, password: password)
                    warning = "waiting for Registration"
                    // Waits 2 seconds for useraddition to the dataBase
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                        self.warning = ""
                        // Fetches the entries from the database for visualization
                        entryDatabase.getData(user: userdataBase.currentUser)
                        // Navigates to the homePageView by toggling booleans of the contentViewController
                        contentViewController.registryView.toggle()s
                        contentViewController.homePageView.toggle()
                    }  
                    self.resetInputs()
                }
                else {
                    warning = "email must be a valid email"
                }
            }
            else {
                warning = "Password must be longer than 6 characters and match confirm password"
            }
        }
        else {
            warning = "Please fill all Textfields"
        }        
    }
    
    // Validates the Email against a given regex
    func validateEmail() -> Bool {
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
    
    // Checks if the needed credentials are given
    func validateCredentials() -> Bool {
        if email != "" && password != "" && confirmPassword != "" {
            return true
        }
        else {
            return false
        }
    }
    
    // Validates if the password matches the minimum length for the firebase database
    func validatePassword() -> Bool {
        if(password.count > 6) {
            if password == confirmPassword  {
                return true
            }
        }
        return false
    }
    
    // Resets the inputs in case the user gets to the registryView later
    func resetInputs() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    // navigates to the loginView by toggling the booleans of the contentViewController
    func back(contentViewController: ContentViewController) {
        contentViewController.registryView.toggle()
        contentViewController.loginView.toggle()
    }
}
