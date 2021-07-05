//
//  entryDatabaseTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class entryDatabaseTests: XCTestCase {
    
    func testAddEntry() {
        
        let entry = Entry(
            entryTitle: "UnitTest",
            entryDescription: "UnitTest",
            createdByUser: "test@test.de",
            acceptedByUser: ""
        )
        let entryDatabase = EntryDatabase()
        let userDatabase = UserDatabase()
        let user = User(email: "test@test.de", password: "password")
        userDatabase.loginUser(email: user.email, password: user.password)
        let addingExpectation = expectation(description: "waiting for entry to be added")
        let queryExpectation = expectation(description: "waiting for entry-query")
        
        entryDatabase.addEntry(entry: entry)
        // waits for the database to add an entry
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            addingExpectation.fulfill()
        }
        
        entryDatabase.getData(user: user)
        // Waits for the database to fetch the entry for further validation
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            queryExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(entryDatabase.entriesForUser.contains(where: { $0.id == entry.id }), "Failed to add Entry")
    }    
    
    func testChangeEntry() {
        var successfull: Bool = false
        var newEntry = Entry(
            entryTitle: "",
            entryDescription: "",
            createdByUser: "",
            acceptedByUser: ""
        )
        let entryDatabase = EntryDatabase()
        let user = User(email: "test@test.de", password: "password")
        let queryExpectation = expectation(description: "waiting for entry-query")
        let changeExpectation = expectation(description: "waiting for entry to be changed")
        
        entryDatabase.getData(user: user)
        // Waits for the database to fetch the entry for further validation
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            for entry in entryDatabase.entriesForUser {
                if entry.entryTitle == "UnitTest" {
                    newEntry = entry
                }
            }
            newEntry.entryTitle = "changed Entry"
            
            entryDatabase.changeEntry(entry: newEntry)
            // Waits for the database to change the entry
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                changeExpectation.fulfill()
                
                entryDatabase.getData(user: user)
                // Waits for the database to fetch the entry for further validation
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    for entry in entryDatabase.entriesForUser {
                        if entry.entryTitle == "changed Entry" {
                            successfull = true
                        }
                    }
                    queryExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(successfull, "Failed to change Entry")
    }
    
    func testDeleteEntry() {
        var successfull: Bool = false
        let entryDatabase = EntryDatabase()
        let user = User(email: "test@test.de", password: "password")
        var databaseEntry: Entry = Entry(
            entryTitle: "",
            entryDescription: "",
            createdByUser: "",
            acceptedByUser: ""
        )
        let deleteExpectation = expectation(description: "waiting for entry to be deleted")
        let queryExpectation = expectation(description: "waiting for entry-query")
        
        entryDatabase.getData(user: user)
        // Waits for the database to fetch the entry for further validation
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            for entry in entryDatabase.entriesForUser {
                if entry.entryTitle == "changed Entry" {
                    databaseEntry = entry
                }
            }
            entryDatabase.deleteEntry(entry: databaseEntry)
            // Waits for the database to delete the enry
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                
                entryDatabase.getData(user: user)
                // Waits for the database to fetch the entry for further validation
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                    
                    if entryDatabase.entriesForUser.contains(where: {
                        $0.entryTitle == "changed Entry"
                    }) {
                        successfull = false
                    }
                    else {
                        successfull = true
                    }
                    deleteExpectation.fulfill()
                    queryExpectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 7, handler: nil)
        
        XCTAssert(successfull, "Failed to delete Entry")
    }
}
