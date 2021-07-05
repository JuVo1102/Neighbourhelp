//
//  CreateEntryViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import SwiftUI

class CreateEntryViewController: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var warning = ""
    
    func addEntryToDatabase(entryDatabase: EntryDatabase, userDatabase: UserDatabase, contentViewController: ContentViewController) {       
        if checkInputs() {
            let entry = Entry(entryTitle: title, entryDescription: description, createdByUser: userDatabase.currentUser.email, acceptedByUser: "")
            entryDatabase.addEntry(entry: entry)
            UIApplication.shared.endEditing()
            self.clearInputs()
            self.warning = "Request successfully created!"
            entryDatabase.getData(user: userDatabase.currentUser)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.warning = ""
            }
        }
        else {
            warning = "Title and description must have a value"
        }
    }
    
    func checkInputs() -> Bool {
        if title != "" && description != "" {
            return true
        }
        else {
            return false
        }
    }
    
    func clearInputs() {
        title = ""
        description = ""
    }
}
