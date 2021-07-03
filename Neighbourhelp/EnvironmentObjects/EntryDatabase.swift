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
    @Published var entriesForUser: [Entry] = []
    
    func addOrChangeEntry(entry: Entry){
        let object: [String: String] = [
            "entryTitle": entry.entryTitle,
            "entryDescription": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ]
        self.database.child("Entries").child(entry.id.uuidString).setValue(object)
    }
       
    
    func getData(user: User) {
        // Quelle: https://www.youtube.com/watch?v=tpsffoRh9u0
        print("getData was called")
        self.database.child("Entries").observeSingleEvent(of: .value, with: {snapshot in
            guard let value =  snapshot.value as? [String: NSObject]
            else {
                print("returned")
                return
            }
            for entry in value {
                let tmpEntry = Entry(
                    id: UUID(uuidString: entry.key) ?? UUID(),
                    entryTitle: entry.value.value(forKey: "entryTitle") as? String ?? "",
                    entryDescription: entry.value.value(forKey: "entryDescription") as? String ?? "",
                    createdByUser: entry.value.value(forKey: "createdByUser") as? String ?? "",
                    acceptedByUser: entry.value.value(forKey: "acceptedByUser") as? String ?? "")
                
                print("entry: \(tmpEntry)")
            }
            
        })
    }
}
