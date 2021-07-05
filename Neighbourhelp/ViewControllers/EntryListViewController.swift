//
//  EntryListViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation

// EntryListViewController to handle logic for the entryListView
class EntryListViewController: ObservableObject {
    // Sections that shall be shown by the view
    @Published var sections = [
        SectionViewModel(header: "Accepted requests", entries: []),
        SectionViewModel(header: "Open requests", entries: [])
        ]
    @Published var openEntries: [Entry] = []
    @Published var acceptedEntries: [Entry] = []   
    
    // Fetches the entries for the different sections
    func queryEntries(entryDatabase: EntryDatabase, userDatabase: UserDatabase) {
        sections[0].entries = entryDatabase.entriesForUser.filter{ $0.acceptedByUser == userDatabase.currentUser.email}
        sections[1].entries = entryDatabase.entriesForUser.filter{ $0.acceptedByUser == ""}
    }
}
