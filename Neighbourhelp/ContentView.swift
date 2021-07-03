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
    @EnvironmentObject var entryDataBase: EntryDatabase
    @EnvironmentObject var userDataBase: UserDatabase
    
    var body: some View {
        // Quelle für Navigation: https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-full-screen-modal-view-using-fullscreencover vom 02.07.2021
        LoginView()
            .fullScreenCover(isPresented: $viewController.loginView, content: LoginView.init)
            .environmentObject(viewController)
            .environmentObject(loginController)
            .environmentObject(registryController)
            .environmentObject(createEntryController)
            .environmentObject(entryListController)
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
            .environmentObject(UserDatabase())
            .environmentObject(EntryDatabase())
    }
}
