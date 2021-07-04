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
        if title != "" && description != "" {
            let entry = Entry(entryTitle: title, entryDescription: description, createdByUser: userDatabase.currentUser.email, acceptedByUser: "")
            entryDatabase.addEntry(entry: entry)
            UIApplication.shared.endEditing()
            title = ""
            description = ""
            warning = "Request successfully created!"
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                self.warning = ""
            }
        }
        else {
            warning = "Title and description must have a value"
        }
    }
}
