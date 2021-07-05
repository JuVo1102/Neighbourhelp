//
//  CreateEntryViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import SwiftUI

// CreateEntryViewController  to handle logic for the registryView
class CreateEntryViewController: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var warning = ""
    
    // Adds an entry to the firebase database by calling the addEntry function of the database
    func addEntryToDatabase(entryDatabase: EntryDatabase, userDatabase: UserDatabase, contentViewController: ContentViewController) {       
        if checkInputs() {
            // Initialization of the entry that is going to be added to the database
            let entry = Entry(entryTitle: title, entryDescription: description, createdByUser: userDatabase.currentUser.email, acceptedByUser: "")
            entryDatabase.addEntry(entry: entry)
            // Dismisses the keyboard -> look into Extensions.swift
            UIApplication.shared.endEditing()
            self.clearInputs()
            self.warning = "Request successfully created!"
            // Fetches the entries from the database for visualization
            entryDatabase.getData(user: userDatabase.currentUser)
            // Waits for the databasequery
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.warning = ""
            }
        }
        else {
            warning = "Title and description must have a value"
        }
    }
    
    // Checks if the inputs for the entry are valid
    func checkInputs() -> Bool {
        if title != "" && description != "" {
            return true
        }
        else {
            return false
        }
    }
    
    // Clears the inputs if the user wants to add multiple entries to the database or in case the user comes back to the CreateEntryView to a later time
    func clearInputs() {
        title = ""
        description = ""
    }
}
