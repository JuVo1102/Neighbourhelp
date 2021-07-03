//
//  CreateEntryViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation

class CreateEntryViewController: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var warning = ""
    
    func addEntryToDatabase(entryDatabase: EntryDatabase, userDatabase: UserDatabase, contentViewController: ContentViewController) {
        if title != "" && description != "" {
            let entry = Entry(entryTitle: title, entryDescription: description, createdByUser: userDatabase.currentUser.email, acceptedByUser: "")
            entryDatabase.addOrChangeEntry(entry: entry)
            title = ""
            description = ""
            contentViewController.tabSelection = 0
        }
        else {
            warning = "Title and description must have a value"
        }
    }
}
