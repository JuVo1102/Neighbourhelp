//
//  SubtitleRow.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import SwiftUI

// Quelle für die table-navigation: https://stackoverflow.com/questions/63197064/how-does-one-use-navigationlink-isactive-binding-when-working-with-list-in-swift

// Custom Rows for a List
struct SubtitleRow<T: StringProtocol>: View {
    var text: T
    var detailText: T
    var entry: Entry
    var listEntryId: UUID? = nil
    @State var selectedEntry: UUID? = nil
    
    var body: some View {
        VStack (alignment: .leading){
            // Displaytext of a single row
            Text(text)
                .font(.subheadline)
                .onTapGesture {
                    selectedEntry = listEntryId
                }
                // Navigationlink to the detailsubview of the tapped entry
                .background(
                    NavigationLink(
                        destination: RequestDetailsView(entry: entry, selection: $selectedEntry),
                        // specific tags to handle navigation
                        tag: listEntryId!,
                        selection: $selectedEntry) {
                        Text(text)
                            .font(.subheadline)
                    }
                )
                // Subheader to display the creator of the entry
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
