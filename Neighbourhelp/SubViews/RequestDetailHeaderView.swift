//
//  RequestDetailHeaderView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 04.07.21.
//

import SwiftUI

// Custom Header for the detailView of the entries to show which user accepted the specific entry

struct RequestDetailHeaderView: View {
    @State var title: String
    @State var acceptedByUser: String
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
            Text("accepted by: ´\(acceptedByUser)")
                .font(.caption)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct RequestDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailHeaderView(title: "title", acceptedByUser: "user")
    }
}
