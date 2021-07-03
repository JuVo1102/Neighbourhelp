//
//  EntryListView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var entryListViewController: EntryListViewController
    @EnvironmentObject var entryDataBase: EntryDatabase
    @EnvironmentObject var userDataBase: UserDatabase
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entryListViewController.sections) {
                    section in Section(header: Text(section.header)) {
                        ForEach(section.entries) {
                            SubtitleRow(text: $0.entryTitle, detailText: $0.createdByUser)
                        }
                    }
                }
            }
            .onAppear {
                entryDataBase.getData(user: userDataBase.currentUser)
                entryListViewController.queryEntries(entryDatabase: entryDataBase, userDataBase: userDataBase)
            }
        }
    }    
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
            .environmentObject(ContentViewController())
            .environmentObject(EntryListViewController())
            .environmentObject(EntryDatabase())
            .environmentObject(UserDatabase())
        
    }
}
