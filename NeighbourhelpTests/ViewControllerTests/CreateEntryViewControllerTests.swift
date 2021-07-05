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
        var successfull = false
        let loginExpectation = self.expectation(description: "waiting for login")
        let queryExpectation = self.expectation(description: "waiting for data query")
        let addingExpectation = self.expectation(description: "waiting for entry addition")
        let deleteExpectation = self.expectation(description: "waiting for deletion")
        
        userDatabase.loginUser(email: email, password: password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            
            createEntryViewController.addEntryToDatabase(
                entryDatabase: entryDatabase,
                userDatabase: userDatabase,
                contentViewController: contentviewController)
            // Waits for the database to add the entry
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                addingExpectation.fulfill()
            }
            
            entryDatabase.getData(user: userDatabase.currentUser)
            // Waits for the database to fetch the entry for further validation
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                if entryDatabase.entriesForUser.contains(where: {
                    $0.entryTitle == "unitTest"
                }) {
                    successfull = true
                }
                else {
                    successfull = false
                    
                }
                for entry in entryDatabase.entriesForUser {
                    if entry.entryTitle == "unitTest" {
                        entryDatabase.deleteEntry(entry: entry)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                            // Deletes the entry to keep the database clean
                            deleteExpectation.fulfill()
                        }
                    }
                }
                
                queryExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 7, handler: nil)
        XCTAssert(successfull, "Failed to add Entry")
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

