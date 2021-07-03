//
//  SubtitleRow.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import SwiftUI

struct SubtitleRow<T: StringProtocol>: View {
    var text: T
    var detailText: T
    var body: some View {
        VStack (alignment: .leading){
            Text(text)
                .font(.subheadline)
            Text("from user: \(detailText as! String)")
                .font(.caption)
        }
    }
}

struct SubtitleRow_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleRow(text: "Title", detailText: "Subtitle")
    }
}
