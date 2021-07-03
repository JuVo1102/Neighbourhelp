//
//  SectionViewModel.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import Foundation

struct SectionViewModel<T: StringProtocol>: Identifiable {
    var id: String {
        return header.description
    }
    
    var header: T
    var footer: T?
    var entries: [Entry]
}
