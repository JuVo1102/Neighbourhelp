//
//  EntryModel.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import Foundation

struct Entry: Identifiable {
    var id = UUID()
    var entryTitle: String
    var entryDescription: String
    var createdByUser: String
    var acceptedByUser: String
}
