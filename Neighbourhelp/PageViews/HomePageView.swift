//
//  HomePageView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var viewController: ContentViewController
    @EnvironmentObject var userDatabase: UserDatabase
    @EnvironmentObject var entryDatabase: EntryDatabase
    
    var body: some View {
        TabView(selection: $viewController.tabSelection) {
            EntryListView().tag(0)
                .tabItem {
                    Label("Entries", image: "")
                }
            CreateEntryView().tag(1)
                .tabItem {
                    Label("Create entry", image: "")
                }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(ContentViewController())
            .environmentObject(UserDatabase())
            .environmentObject(EntryDatabase())
    }
}
