//
//  userDatabaseTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

// Quelle: https://developer.apple.com/documentation/xctest/asynchonous_tests_and_expextations/testing_asynchronous_operations_with_expectations

class userDatabaseTests: XCTestCase {
    
    func testLoginDatabase() {
        
        let user = User(email: "test@test.de", password: "password")
        let userDatabase = UserDatabase()
        let expectation = self.expectation(description: "waiting for database")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(
            userDatabase.currentUser.email == user.email,
            "Failed to login user"
        )
    }
    
    // Wird fehlschlagen, wenn es den User bereits gibt
    func testAddUser() {
        
        let user = User(email: "any@any.de", password: "anyPassword")
        let userDatabase = UserDatabase()
        let addingExpectation = self.expectation(description: "waiting for user to be added to userDatabase")
        let loginExpectation = self.expectation(description: "waiting for database")
        
        userDatabase.AddUser(email: user.email, password: user.password)
        // Waits for the database to add a new user
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            addingExpectation.fulfill()
        }
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)        
        XCTAssert(userDatabase.currentUser.email == user.email, "Failed to Add user to the Database")
        
    }
    
    func testLogout() {
        let user = User(email: "test@test.de", password: "anyPassword")
        let userDatabase = UserDatabase()
        let logoutExpectation = self.expectation(description: "Waiting for logout")
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            loginExpectation.fulfill()
            
            userDatabase.logout()
            // Waits for the user to be logged out
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                logoutExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(userDatabase.currentUser.email == "", "Failed to logout user")
    }
}
