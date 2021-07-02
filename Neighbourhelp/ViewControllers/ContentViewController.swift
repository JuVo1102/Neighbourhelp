//
//  ContentViewController.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import Foundation
import UIKit

class ContentViewController:  UIViewController, ObservableObject {
    @Published var loginView: Bool = true
    @Published var tabView: Bool = false
    @Published var registryView: Bool = false;
    @Published var fullScreen: Bool = true    
}

