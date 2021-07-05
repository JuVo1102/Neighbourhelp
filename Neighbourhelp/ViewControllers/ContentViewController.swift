//
//  ContentViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import Foundation
import UIKit

// Used to navigate through the app by toggling the views to be active or inactive based on the bool status
class ContentViewController:  UIViewController, ObservableObject {
    @Published var loginView: Bool = true
    @Published var homePageView: Bool = false
    @Published var registryView: Bool = false;
    @Published var entryDetailView: Bool = false;
    @Published var tabSelection = 0
    @Published var fullScreen: Bool = true    
    
    func navigateToLogin() {
        homePageView.toggle()
        loginView.toggle()
    }
}

