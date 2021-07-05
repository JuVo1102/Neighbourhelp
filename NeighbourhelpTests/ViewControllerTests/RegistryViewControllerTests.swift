//
//  RegistryViewControllerTests.swift
//  NeighbourhelpTests
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import XCTest

@testable import Neighbourhelp

class RegistryViewControllerTests: XCTestCase {
    
    func testRegister() {
        let userDatabase = UserDatabase()
        let entryDatabase = EntryDatabase()
        let contentViewController = ContentViewController()
        let registryViewController = RegistryViewController()
        registryViewController.email = "unitTest@unitTest.de"
        registryViewController.password = "testPassword"
        registryViewController.confirmPassword = "testPassword"
        let registryExpectation = self.expectation(description: "waiting for registration")
        
        registryViewController.register(
            userdataBase: userDatabase,
            entryDatabase: entryDatabase,
            contentViewController: contentViewController)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            print("current User: \(userDatabase.currentUser)")
            registryExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(userDatabase.currentUser.email == "unitTest@unitTest.de", "Failed to register user")
    }
    
    func testValidateCredentials() {
        let registryViewController = RegistryViewController()
        registryViewController.email = "unitTest@unitTest.de"
        registryViewController.password = "testPassword"
        registryViewController.confirmPassword = "testPassword"
        
        XCTAssert(registryViewController.validateCredentials(), "Credentials not valid")
    }
    
    func testValidateEmail() {
        let registryViewController = RegistryViewController()
        registryViewController.email = "unitTest@unitTest.de"
        
        XCTAssert(registryViewController.validateEmail(), "Email not valid")
    }
    
    func testResetInputs() {
        let registryViewController = RegistryViewController()
        registryViewController.email = "unitTest@unitTest.de"
        registryViewController.password = "testPassword"
        registryViewController.confirmPassword = "testPassword"
        
        registryViewController.resetInputs()
        
        XCTAssert(
            registryViewController.email == "" &&
                registryViewController.password == "" &&
                registryViewController.confirmPassword == "", "Failed to reset credentials")
    }
    
    func testValidatePassword() {
        let registryViewController = RegistryViewController()
        registryViewController.password = "testPassword"
        registryViewController.confirmPassword = "testPassword"
        
        XCTAssert(registryViewController.validatePassword(), "Password not valid")
    }
}
