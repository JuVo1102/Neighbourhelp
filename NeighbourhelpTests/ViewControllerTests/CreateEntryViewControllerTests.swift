//
//  CreateEntryViewControllerTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class CreateEntryViewControllerTests: XCTestCase {
    
    func testAddEntryToDatabase() {
        let entryDatabase = EntryDatabase()
        let userDatabase = UserDatabase()
        let contentviewController = ContentViewController()
        let createEntryViewController = CreateEntryViewController()
        createEntryViewController.title = "unitTest"
        createEntryViewController.description = "unitTest"
        let email = "test@test.de"
        let password = "password"
        let loginExpectation = self.expectation(description: "waiting for login")
        let queryExpectation = self.expectation(description: "waiting for data query")
        let addingExpectation = self.expectation(description: "waiting for entry addition")
        
        userDatabase.loginUser(email: email, password: password)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            print("current user \(userDatabase.currentUser)")
            loginExpectation.fulfill()
            
            createEntryViewController.addEntryToDatabase(
                entryDatabase: entryDatabase,
                userDatabase: userDatabase,
                contentViewController: contentviewController)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                addingExpectation.fulfill()
            }
            
            entryDatabase.getData(user: userDatabase.currentUser)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                queryExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(entryDatabase.entriesForUser.contains(where: { $0.entryTitle == "unitTest"}), "Failed to add Entry")
    }
    
    func testCheckInputs() {
        let createEntryViewController = CreateEntryViewController()
        createEntryViewController.title = "unitTest"
        createEntryViewController.description = "unitTest"
        
        XCTAssert(createEntryViewController.checkInputs(), "Either title or description is empty")
    }
    
    func testClearInputs() {
        let createEntryViewController = CreateEntryViewController()
        createEntryViewController.title = "unitTest"
        createEntryViewController.description = "unitTest"
        
        createEntryViewController.clearInputs()
        
        XCTAssert(
            createEntryViewController.title == "" &&
                createEntryViewController.description == "",
            "Failed to clear inputs")
    }
}

