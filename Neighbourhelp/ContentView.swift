//
//  ContentView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewController: ContentViewController
    @EnvironmentObject var loginController: LoginViewController
    @EnvironmentObject var registryController: RegistryViewController
    @EnvironmentObject var createEntryController: CreateEntryViewController
    @EnvironmentObject var entryListController: EntryListViewController
    @EnvironmentObject var requestDetailsController: RequestDetailsViewController
    @EnvironmentObject var entryDataBase: EntryDatabase
    @EnvironmentObject var userDataBase: UserDatabase
    
    var body: some View {
        // Quelle für Navigation: https://developer.apple.com/forums/thread/667742
        VStack {
            if viewController.loginView {
                LoginView()
            }
            else if viewController.registryView {
                RegistryView()
            }
            else if viewController.homePageView {
                HomePageView()
            }
        }
        .environmentObject(viewController)
        .environmentObject(loginController)
        .environmentObject(registryController)
        .environmentObject(createEntryController)
        .environmentObject(entryListController)
        .environmentObject(requestDetailsController)
        .environmentObject(userDataBase)
        .environmentObject(entryDataBase)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewController())
            .environmentObject(LoginViewController())
            .environmentObject(RegistryViewController())
            .environmentObject(CreateEntryViewController())
            .environmentObject(EntryListViewController())
            .environmentObject(RequestDetailsViewController())
            .environmentObject(UserDatabase())
            .environmentObject(EntryDatabase())
    }
}
