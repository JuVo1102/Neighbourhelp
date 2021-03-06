//
//  RequestDetailsViewControllerTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class RequestDetailsViewControllerTests: XCTestCase {
    
    // Tests if the process function successfully changes an entry in the database
    func testProcessValidatedInputs() {
        let requestDetailsViewController = RequestDetailsViewController()
        let newEntry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "",
            acceptedByUser: "")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let entryDatabase = EntryDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        let addingExpectation = expectation(description: "waiting for entry to be added")
        let queryExpectation = expectation(description: "waiting for entry-query")
        let changeExpectation = expectation(description: "waiting for entry to be changed")
        var successfull = false
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            
            entryDatabase.addEntry(entry: newEntry)
            // Waits for the database to fetch the entry for further validation
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                addingExpectation.fulfill()
                
                var uuid: UUID? = newEntry.id
                requestDetailsViewController.process(entry: newEntry, entryDatabase: entryDatabase, userDatabase: userDatabase, selection: &uuid)
                // Waits for the process function of the viewController
                // Either changing an entry or deleting an entry
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                    changeExpectation.fulfill()
                    
                    entryDatabase.getData(user: user)
                    // Waits for the database to fetch the entry for further validation
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                        for entry in entryDatabase.entriesForUser {
                            print(entry.entryTitle)
                            if entry.entryTitle == "UnitTest" && entry.acceptedByUser == userDatabase.currentUser.email {
                                successfull = true
                                entryDatabase.deleteEntry(entry: entry)
                            }
                        }
                        queryExpectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 12, handler: nil)
        
        XCTAssert(successfull, "Failed to change Entry")
    }
    
    // Tests if the process function successfully deletes an entry in the database
    func testProcessDelete() {
        let requestDetailsViewController = RequestDetailsViewController()
        let newEntry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "user",
            acceptedByUser: "xy")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let entryDatabase = EntryDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        let addingExpectation = expectation(description: "waiting for entry to be added")
        let queryExpectation = expectation(description: "waiting for entry-query")
        let changeExpectation = expectation(description: "waiting for entry to be changed")
        var successfull = false
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            
            entryDatabase.addEntry(entry: newEntry)
            // Waits for the database to add an Entry
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                addingExpectation.fulfill()
                
                var uuid: UUID? = newEntry.id
                requestDetailsViewController.process(entry: newEntry, entryDatabase: entryDatabase, userDatabase: userDatabase, selection: &uuid)
                // Waits for the database to delete an entry
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                    changeExpectation.fulfill()
                    
                    entryDatabase.getData(user: user)
                    // Waits for the database to fetch the entry for further validation
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                        for entry in entryDatabase.entriesForUser {
                            print(entry.entryTitle)
                            if entry.entryTitle == "UnitTest" {
                                successfull = false
                            }
                            else {
                                successfull = true
                            }
                        }
                        queryExpectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 12, handler: nil)
        
        XCTAssert(successfull, "Failed to change Entry")
    }
    
    func testValidateInputs() {
        let requestDetailsViewController = RequestDetailsViewController()
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "UnitTest",
            acceptedByUser: "")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(requestDetailsViewController.validateInputs(
                    entry: entry,
                    userDatabase: userDatabase),
                  "Inputs not Valid")
    }
    
    // The following tests test the different visualizations for the button in the requestDetailsView based on the status of the given entry
    
    func testCheckButtonComplete () {
        let requestDetailsViewController = RequestDetailsViewController()
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "UnitTest",
            acceptedByUser: "UnitTest")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            requestDetailsViewController.checkButton(entry: entry, userDataBase: userDatabase)
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(requestDetailsViewController.disabled == false &&
                    requestDetailsViewController.opacity == 1.0,
                  "Inputs not Valid")
    }
    
    func testCheckButtonHidden () {
        let requestDetailsViewController = RequestDetailsViewController()
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "UnitTest",
            acceptedByUser: "test@test.de")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            requestDetailsViewController.checkButton(entry: entry, userDataBase: userDatabase)
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(requestDetailsViewController.disabled == true &&
                    requestDetailsViewController.opacity == 0.0,
                  "Inputs not Valid")
    }
    
    func testCheckButtoDelete () {
        let requestDetailsViewController = RequestDetailsViewController()
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "test@test.de",
            acceptedByUser: "")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            requestDetailsViewController.checkButton(entry: entry, userDataBase: userDatabase)
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(requestDetailsViewController.disabled == false &&
                    requestDetailsViewController.opacity == 1.0,
                  "Inputs not Valid")
    }
    
    func testCheckButtoAccept () {
        let requestDetailsViewController = RequestDetailsViewController()
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "",
            acceptedByUser: "")
        let user = User(
            email: "test@test.de",
            password: "password")
        let userDatabase = UserDatabase()
        let loginExpectation = self.expectation(description: "waiting for login")
        
        userDatabase.loginUser(email: user.email, password: user.password)
        // Waits for the user to be logged in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            requestDetailsViewController.checkButton(entry: entry, userDataBase: userDatabase)
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(requestDetailsViewController.disabled == false &&
                    requestDetailsViewController.opacity == 1.0,
                  "Inputs not Valid")
    }
}
