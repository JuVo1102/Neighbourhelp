//
//  ChatView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var userDatabase: UserDatabase
    @EnvironmentObject var entryDatabase: EntryDatabase
    
    var body: some View {
        NavigationView {
            Text("Hello, Chat!")
        }
        .navigationBarTitle("Chats")
        .navigationBarItems(
            trailing:
                Button("Logout: \(userDatabase.currentUser.email)") {
            EmptyView()
        })
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environmentObject(ContentViewController())
            .environmentObject(EntryDatabase())
            .environmentObject(UserDatabase())
    }
}
