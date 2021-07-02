//
//  EntryDatabase.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import FirebaseDatabase

// Quelle: https://firebase.google.com/docs/database/ios/read-and-write am 02.07.2021
class EntryDatabase: ObservableObject {
    @Published var database: DatabaseReference! = Database.database().reference()
    
    func addEntry(entry: Entry){
        self.database.child("Entries").child(entry.id.uuidString).setValue([
            "title": entry.entryTitle,
            "description": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ])
    }
    
    func overRideEntry(entry: Entry) {
        self.database.child("Entries/\(entry.id.uuidString)").setValue([
            "title": entry.entryTitle,
            "description": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ])
    }
}
