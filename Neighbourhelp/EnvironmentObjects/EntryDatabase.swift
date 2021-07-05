//
//  EntryDatabase.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation
import FirebaseDatabase

// Quelle: https://firebase.google.com/docs/database/ios/read-and-write am 02.07.2021

// Firebase-realtime-database to store data. In this case requests

class EntryDatabase: ObservableObject {
    // Gets a reference of the database
    @Published var database: DatabaseReference! = Database.database().reference()
    // Local array to store data from the database locally and used for synchronization with the frontend
    @Published var entriesForUser: [Entry] = []
    
    // Adds a entry into the database at the defined path
    func addEntry(entry: Entry){
        print("addEntry was called")
        let object: [String: String] = [
            "entryTitle": entry.entryTitle,
            "entryDescription": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ]
        self.database.child("Entries").child(entry.id.uuidString).setValue(object)
    }
    
    // Changes a entry into the database at the defined path
    func changeEntry(entry: Entry) {
        print("changeEntry was called")
        let object: [String: String] = [
            "entryTitle": entry.entryTitle,
            "entryDescription": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ]
        database.child("Entries").child(entry.id.uuidString).updateChildValues(object)
        
    }
    
    // Deletes an entry from the database at the defined path
    func deleteEntry(entry: Entry) {
        // Quelle: https://www.codegrepper.com/code-examples/swift/remove+child+from+firebase+swift
        self.database.child("Entries").child(entry.id.uuidString).removeValue {
            error, success  in
            if error != nil {
                print("error: \(error?.localizedDescription ?? "error while deleting")")
            }
            else {
                print("successfully deleted")
            }
        }
    }
    
    
    func getData(user: User) {
        let group = DispatchGroup()
        // Quelle: https://www.youtube.com/watch?v=tpsffoRh9u0
        print("getData was called")
        group.enter()
        self.database.child("Entries").getData { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "error while queriyng data")
            }
            else {
                guard let value =  snapshot.value as? [String: NSObject]
                else {
                    self.entriesForUser = []
                    print("returned")
                    return
                }
                var newEntries: [Entry] = []
                for entry in value {
                    let tmpEntry = Entry(
                        id: UUID(uuidString: entry.key) ?? UUID(),
                        entryTitle: entry.value.value(forKey: "entryTitle") as? String ?? "",
                        entryDescription: entry.value.value(forKey: "entryDescription") as? String ?? "",
                        createdByUser: entry.value.value(forKey: "createdByUser") as? String ?? "",
                        acceptedByUser: entry.value.value(forKey: "acceptedByUser") as? String ?? ""
                    )
                    newEntries.append(tmpEntry)
                    self.entriesForUser = newEntries
                }
                group.leave()
            }
        }
    }
}
