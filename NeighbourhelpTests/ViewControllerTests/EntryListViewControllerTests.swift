//
//  EntryListViewControllerTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class EntryListViewControllerTests: XCTestCase {
    
    func testQueryEntries() {
        let entrylistViewController = EntryListViewController()
        let entryDatabase = EntryDatabase()
        let userDatabase = UserDatabase()
        let email = "test@test.de"
        let password = "password"
        let loginExpectation = self.expectation(description: "waiting for login")
        let queryExpectation = self.expectation(description: "waiting for data query")
        
        userDatabase.loginUser(email: email, password: password)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            loginExpectation.fulfill()
            
            entryDatabase.getData(user: userDatabase.currentUser)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                queryExpectation.fulfill()
                
                entrylistViewController.queryEntries(
                    entryDatabase: entryDatabase,
                    userDatabase: userDatabase
                )
                print("Accepted entries: \(entrylistViewController.sections[0])")
                print("Open entries: \(entrylistViewController.sections[1])")
            }
        }
        
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssert(
            entrylistViewController.sections[0].entries.allSatisfy({$0.acceptedByUser == userDatabase.currentUser.email}) &&
                entrylistViewController.sections[1].entries.allSatisfy({$0.acceptedByUser == ""}),
            file: "Couldn´t fetch entries arrays")
    }
}
