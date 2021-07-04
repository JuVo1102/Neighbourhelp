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
    @Published var emailIsEditing: Bool = false
    @Published var passwordIsEditing: Bool = false
    
    
    func login(userDataBase: UserDatabase, entryDataBase: EntryDatabase, contentViewController: ContentViewController) {
        if password != "" && email != "" {
            // Quelle: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expression-in-swift
            let range = NSRange(location: 0, length: email.utf16.count)
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
            let regex = try! NSRegularExpression(pattern: emailRegEx)
            
            if regex.firstMatch(in: email, options: [], range: range) == nil {
                warning = "email must be a valid email"
            }
            else {
                userDataBase.loginUser(email: email, password: password)
                entryDataBase.getData(user: userDataBase.currentUser)
                contentViewController.homePageView = true
            }
            email = ""
            password = ""
        }
        else {
            warning = "email and passwort needs to be filled in"
        }
        
    }
    
    func navigateToRegistry(contentViewController: ContentViewController) {
        contentViewController.registryView = true
    }
}
