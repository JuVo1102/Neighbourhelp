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
    var listEntryId: UUID? = nil
    @State var selectedEntry: UUID? = nil
    
    var body: some View {
        VStack (alignment: .leading){
            Text(text)
                .font(.subheadline)
                .onTapGesture {
                    selectedEntry = listEntryId
                }
                .background(
                    NavigationLink(
                        destination: RequestDetailsView(entry: entry, selection: $selectedEntry),
                        tag: listEntryId!,
                        selection: $selectedEntry) {
                        Text(text)
                            .font(.subheadline)
                    }
                )
                
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
