//
//  RequestDetailsViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation

class RequestDetailsViewController: ObservableObject {
    @Published var hideButton : Bool = true
    @Published var buttonText : String = ""
    @Published var opacity: Double = 0.0
    
    func process(entry: Entry, entryDataBase: EntryDatabase, userDataBase: UserDatabase) {
        if entry.acceptedByUser == "" && entry.createdByUser != userDataBase.currentUser.email {
            var newEntry = entry
            newEntry.acceptedByUser = userDataBase.currentUser.email
            entryDataBase.changeEntry(entry: newEntry, userDataBase: userDataBase)
        }
        else {
            entryDataBase.deleteEntry(entry: entry)
        }
    }
    
    func checkButton (entry: Entry, userDataBase: UserDatabase) {
        if entry.acceptedByUser != "" && entry.createdByUser == userDataBase.currentUser.email {
            self.hideButton = false
            self.buttonText = "Complete"
            self.opacity = 1.0
        }
        else if entry.acceptedByUser == userDataBase.currentUser.email && entry.createdByUser != userDataBase.currentUser.email {
            self.hideButton = true
            self.buttonText = "should be hidedn -> not Creator"
            self.opacity = 0.0
        }
        else if entry.acceptedByUser == "" && entry.createdByUser == userDataBase.currentUser.email {
            self.hideButton = true
            self.buttonText = "Delete"
            self.opacity = 1.0
        }
        else {
            self.hideButton = false
            self.buttonText = "Accept"
            self.opacity = 1.0
        }
    }
}
