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
    var entry: Entry
    var body: some View {
        VStack (alignment: .leading){
            NavigationLink(
                destination: RequestDetailsView(entry: entry),
                label: {
                    Text(text)
                        .font(.subheadline)
                })
                .isDetailLink(false)
                
            Text("from user: \(detailText as! String)")
                .font(.caption)
        }
    }
}

struct SubtitleRow_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleRow(
            text: "Title",
            detailText: "Subtitle",
            entry: Entry(
                entryTitle: "Title",
                entryDescription: "Description",
                createdByUser: "",
                acceptedByUser: "")
            )
    }
}
