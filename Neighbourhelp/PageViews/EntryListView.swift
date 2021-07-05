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
    @EnvironmentObject var entryDatabase: EntryDatabase
    @EnvironmentObject var userDatabase: UserDatabase
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entryListViewController.sections) { section in
                    Section(header:
                                EntryListCustomHeaderView(
                                    sectionName: section.header,
                                    color: Color(hue: 1.0, saturation: 0.028, brightness: 0.864)
                                )
                    )
                    {
                        ForEach(section.entries) {
                            SubtitleRow(text: $0.entryTitle, detailText: $0.createdByUser, entry: $0, listEntryId: $0.id)
                        }
                    }
                }
            }
            .padding(0)
            .onAppear {
                entryListViewController.queryEntries(entryDatabase: entryDatabase, userDatabase: userDatabase)
            }
            .navigationBarTitle("Request-overview")
            .navigationBarItems(
                trailing:
                    Button("Logout: \(userDatabase.currentUser.email)") {
                        userDatabase.logout()
                        contentViewController.navigateToLogin()
                    })
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
