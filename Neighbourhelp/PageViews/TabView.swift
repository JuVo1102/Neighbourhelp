//
//  TabView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var userData: UserDatabase
    @EnvironmentObject var contentViewController: ContentViewController
    
    var body: some View {
        Text(userData.currentUser.email)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
            .environmentObject(UserDatabase())
            .environmentObject(ContentViewController())
    }
}
