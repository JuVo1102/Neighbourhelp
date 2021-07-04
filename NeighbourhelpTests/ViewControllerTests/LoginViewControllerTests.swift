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
    
    func testLoginViewController() {
        let userDatabase = UserDatabase()
        let entryDatabase = EntryDatabase()
        let contentViewController = ContentViewController()
        let loginViewController = LoginViewController()
        loginViewController.email = "test@test.de"
        loginViewController.password = "password"
        let loginExpectation = self.expectation(description: "waiting for database")
        
        loginViewController.login(
            userDatabase: userDatabase,
            entryDatabase: entryDatabase,
            contentViewController: contentViewController)
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
