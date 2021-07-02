//
//  UserModel.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var email: String
    var password: String
}
