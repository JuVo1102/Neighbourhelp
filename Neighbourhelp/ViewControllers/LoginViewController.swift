//
//  LoginViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import Foundation
import SwiftUI

class LoginViewController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var warning: String = ""
    
    
    func login(userDatabase: UserDatabase, entryDatabase: EntryDatabase, contentViewController: ContentViewController) {
        if self.checkCredentials() {
            if validateEmail() {
                userDatabase.loginUser(email: email, password: password)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {                    
                    entryDatabase.getData(user: userDatabase.currentUser)
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
    
    func checkCredentials() -> Bool {
        if password != "" && email != "" {
            return true
        }
        else {
            return false
        }
    }
    
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
    
    func resetInputs() {
        email = ""
        password = ""
    }
    
    func navigateToRegistry(contentViewController: ContentViewController) {
        contentViewController.loginView.toggle()
        contentViewController.registryView.toggle()
    }
}
