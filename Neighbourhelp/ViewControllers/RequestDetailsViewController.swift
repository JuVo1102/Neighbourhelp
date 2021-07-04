//
//  RequestDetailsViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation

class RequestDetailsViewController: ObservableObject {
    @Published var disabled : Bool = true
    @Published var buttonText : String = ""
    @Published var opacity: Double = 0.0
    
    func process(entry: Entry, entryDatabase: EntryDatabase, userDatabase: UserDatabase) {
        if validateInputs(entry: entry, userDatabase: userDatabase) {
            var newEntry = entry
            newEntry.acceptedByUser = userDatabase.currentUser.email
            entryDatabase.changeEntry(entry: newEntry)
        }
        else {
            entryDatabase.deleteEntry(entry: entry)
        }
    }
    
    func validateInputs(entry: Entry, userDatabase: UserDatabase) -> Bool {
        if entry.acceptedByUser == "" && entry.createdByUser != userDatabase.currentUser.email {
            return true
        }
        else {
            return false
        }
    }
    
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
