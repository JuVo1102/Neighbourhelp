//
//  RequestDetailsView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import SwiftUI

struct RequestDetailsView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var requestDetailsViewController: RequestDetailsViewController
    @EnvironmentObject var entryListViewController: EntryListViewController
    @EnvironmentObject var userDataBase: UserDatabase
    @EnvironmentObject var entryDatabase: EntryDatabase    
    @State var entry: Entry
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                
                Text(entry.entryDescription)
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                Button(action: {requestDetailsViewController.process(
                        entry: entry,
                        entryDatabase: entryDatabase,
                        userDatabase: userDataBase)}) {
                    Text(requestDetailsViewController.buttonText)
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                .cornerRadius(15.0)
                .opacity(requestDetailsViewController.opacity)
                .disabled(requestDetailsViewController.disabled)
                
                Spacer()
            }
            .onDisappear {
                entryDatabase.getData(user: userDataBase.currentUser)
                entryListViewController.queryEntries(entryDatabase: entryDatabase, userDatabase: userDataBase)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal, content: {
                    RequestDetailHeaderView(title: entry.entryTitle, acceptedByUser: entry.acceptedByUser)
                })
            }
        }
        .onAppear {
            requestDetailsViewController.checkButton(entry: entry, userDataBase: userDataBase)
        }
        .onDisappear {
            entryDatabase.getData(user: userDataBase.currentUser)
        }
    }
}

struct RequestDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailsView(
            entry: Entry(
                entryTitle: "Title",
                entryDescription: "Description",
                createdByUser: "UserXY",
                acceptedByUser: "UserZ")
        )
        .environmentObject(EntryListViewController())
        .environmentObject(ContentViewController())
        .environmentObject(RequestDetailsViewController())
        .environmentObject(UserDatabase())
        .environmentObject(EntryDatabase())
    }
}
