//
//  EntryListView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var entryDataBase: EntryDatabase
    @EnvironmentObject var userDataBase: UserDatabase
    
    var body: some View {
        NavigationView {
            List(entryDataBase.entriesForUser) { entry in
                SubtitleRow(text: entry.entryTitle, detailText: entry.createdByUser)
            }
        }
        .onAppear {
            print("EntryViewDidLoad")
            entryDataBase.getData(user: userDataBase.currentUser)
        }
    }    
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
            .environmentObject(EntryDatabase())
            .environmentObject(UserDatabase())
        
    }
}
