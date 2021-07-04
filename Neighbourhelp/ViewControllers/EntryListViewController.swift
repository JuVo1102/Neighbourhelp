//
//  EntryListViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation

class EntryListViewController: ObservableObject {
    @Published var sections = [
        SectionViewModel(header: "Accepted requests", entries: []),
        SectionViewModel(header: "Open requests", entries: [])
        ]
    @Published var openEntries: [Entry] = []
    @Published var acceptedEntries: [Entry] = []   
    
    func queryEntries(entryDatabase: EntryDatabase, userDatabase: UserDatabase) {
        sections[0].entries = entryDatabase.entriesForUser.filter{ $0.acceptedByUser == userDatabase.currentUser.email}
        sections[1].entries = entryDatabase.entriesForUser.filter{ $0.acceptedByUser == ""}
    }
}
