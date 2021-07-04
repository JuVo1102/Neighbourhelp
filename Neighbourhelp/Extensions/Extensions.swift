//
//  Extensions.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 04.07.21.
//

import Foundation
import SwiftUI

/* Quelle: https://www.hackingwithswift.com/forums/swiftui/textfield-dismiss-keyboard-clear-button/240 */
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
