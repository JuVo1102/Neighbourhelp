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
    
    func addEntry(entry: Entry, userDataBase: UserDatabase) {
        let object: [String: String] = [
            "entryTitle": entry.entryTitle,
            "entryDescription": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ]
        self.database.child("Entries").child(entry.id.uuidString).setValue(object)
        self.getData(user: userDataBase.currentUser)
    }
    
    func changeEntry(entry: Entry, userDataBase: UserDatabase) {
        let object: [String: String] = [
            "entryTitle": entry.entryTitle,
            "entryDescription": entry.entryDescription,
            "createdByUser": entry.createdByUser,
            "acceptedByUser": entry.acceptedByUser
        ]
        database.child("Entries").child(entry.id.uuidString).updateChildValues(object)
        self.getData(user: userDataBase.currentUser)
    }
    
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
                    
                    /*let checkElement = self.entriesForUser.first { $0.id == tmpEntry.id }
                    if checkElement != nil {
                        let index = self.entriesForUser.firstIndex { $0.id == tmpEntry.id }
                        self.entriesForUser[index!] = tmpEntry
                    }
                    else {
                        self.entriesForUser.append(tmpEntry)
                    }*/
                    newEntries.append(tmpEntry)
                    self.entriesForUser = newEntries
                }
                group.leave()
            }
        }
    }
}
