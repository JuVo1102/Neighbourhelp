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
                    userdataBase.AddUser(email: email, password: password)
                    warning = "waiting for Registration"
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                        self.warning = ""
                        entryDatabase.getData(user: userdataBase.currentUser)
                        contentViewController.registryView.toggle()
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
    
    func validateCredentials() -> Bool {
        if email != "" && password != "" && confirmPassword != "" {
            return true
        }
        else {
            return false
        }
    }
    
    func validatePassword() -> Bool {
        if(password.count > 6) {
            if password == confirmPassword  {
                return true
            }
        }
        return false
    }
    
    func resetInputs() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    func back(contentViewController: ContentViewController) {
        contentViewController.registryView.toggle()
        contentViewController.loginView.toggle()
    }
}
