//
//  RequestDetailsViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation


// RequestDetailsViewController to handle the logic for the requestDetailsView
class RequestDetailsViewController: ObservableObject {
    @Published var disabled : Bool = true
    @Published var buttonText : String = ""
    @Published var opacity: Double = 0.0
    // Used for navigation
    @Published var isActive: Bool = false
    
    // Checks if the given entry needs to be changed so the acceptedByUser property will be updated or if the entry needs to be deleted because of completion
    func process(entry: Entry, entryDatabase: EntryDatabase, userDatabase: UserDatabase, selection: inout UUID?) {
        // Changes the acceptedByUser property of the entry in the database by calling the changeEntry function of the database
        if validateInputs(entry: entry, userDatabase: userDatabase) {
            var newEntry = entry
            newEntry.acceptedByUser = userDatabase.currentUser.email
            entryDatabase.changeEntry(entry: newEntry)
            // Navigates back out of the detailView
            isActive = false
            selection = nil
        }
        // Deletes the entry because it is completed
        else {
            entryDatabase.deleteEntry(entry: entry)
            isActive = false
            selection = nil
        }
    }
    
    // Validates the Inputs to determine whether the entry needs to be changed or deleted
    func validateInputs(entry: Entry, userDatabase: UserDatabase) -> Bool {
        if entry.acceptedByUser == "" && entry.createdByUser != userDatabase.currentUser.email {
            return true
        }
        else {
            return false
        }
    }
    
    // Manipulates the appearance of the Button based on the status of the entry
    func checkButton (entry: Entry, userDataBase: UserDatabase) {
        if entry.acceptedByUser != "" && entry.createdByUser == userDataBase.currentUser.email {
            self.disabled = false
            self.buttonText = "Complete"
            self.opacity = 1.0
        }
        else if entry.acceptedByUser == userDataBase.currentUser.email && entry.createdByUser != userDataBase.currentUser.email {
            self.disabled = true
            self.buttonText = "should be hidden -> not Creator"
            self.opacity = 0.0
        }
        else if entry.acceptedByUser == "" && entry.createdByUser == userDataBase.currentUser.email {
            self.disabled = false
            self.buttonText = "Delete"
            self.opacity = 1.0
        }
        else {
            self.disabled = false
            self.buttonText = "Accept"
            self.opacity = 1.0
        }
    }
}
