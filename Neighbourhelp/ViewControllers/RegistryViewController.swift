//
//  RegistryViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import SwiftUI

class RegistryViewController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var warning: String = ""
    
    func register(userdataBase: UserDatabase, contentViewController: ContentViewController) {
        if email != "" && password != "" && confirmPassword != "" {
            if(password.count > 6) {
                if password == confirmPassword  {
                    // Quelle: https://www.hackingwithswift.com/articles/108/how-to-use-regular-expression-in-swift
                    let range = NSRange(location: 0, length: email.utf16.count)
                    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}"
                    let regex = try! NSRegularExpression(pattern: emailRegEx)
                    if regex.firstMatch(in: email, options: [], range: range) != nil {
                        userdataBase.AddUser(email: email, password: password)
                        contentViewController.homePageView = true
                    }
                    else {
                        warning = "email must be a valid email"
                    }
                }
                else {
                    warning = "Password and Confirm password do not match"
                }
            }
            else {
                warning = "Password must be longer than 6 characters"
            }
        }
        else {
            warning = "Please fill all Textfields"
        }        
    }
    
    func back(contentViewController: ContentViewController) {
        contentViewController.loginView = true  
    }
}
