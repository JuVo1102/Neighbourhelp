//
//  LoginViewControllerTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class LoginViewControllerTests: XCTestCase {
    
    // Will fail if the user is not registered in the database
    func testLoginViewControllerLogin() {
        let userDatabase = UserDatabase()
        let entryDatabase = EntryDatabase()
        let contentViewController = ContentViewController()
        let loginViewController = LoginViewController()
        loginViewController.email = "test@test.de"
        loginViewController.password = "password"
        let loginExpectation = self.expectation(description: "waiting for login")
        
        loginViewController.login(
            userDatabase: userDatabase,
            entryDatabase: entryDatabase,
            contentViewController: contentViewController)
        // Waits for the login to be completed
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            print(userDatabase.currentUser)
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(userDatabase.currentUser.email == "test@test.de", "Failed to login user")
    }
    
    func testCheckCredentials() {
        let loginViewController = LoginViewController()
        loginViewController.email = "test@test.de"
        loginViewController.password = "password"
        
        XCTAssert(loginViewController.checkCredentials(), "Given credentials are invalid")
    }
    
    func testValidateEmail() {
        let loginViewController = LoginViewController()
        loginViewController.email = "test@test.de"
        
        XCTAssert(loginViewController.validateEmail(), "Email is not valid")
    }
    
    func testResetInputs() {
        let loginViewController = LoginViewController()
        loginViewController.email = "test@test.de"
        loginViewController.password = "password"
        
        loginViewController.resetInputs()
        
        XCTAssert(
            loginViewController.email == "" &&
                loginViewController.password == "",
            "Was not able to reset credentials")
    }
}
