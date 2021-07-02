//
//  HomePageView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var viewController: ContentViewController
    @EnvironmentObject var userData: UserDatabase
    
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
            ChatView().tag(2)
                .tabItem {
                    Label("Chat", image: "")
                }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(ContentViewController())
            .environmentObject(UserDatabase())
    }
}
