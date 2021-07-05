//
//  EntryListCustomHeaderView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 04.07.21.
//

import SwiftUI

// Quelle: https://stackoverflow.com/questions/56867334/remove-change-section-header-background-color-in-swiftui-list
// Custom Listheaders to manipulate the background-color of the header
struct EntryListCustomHeaderView: View {
    @State var sectionName: String
    @State var color: Color
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(sectionName)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }
        .padding(0)
        .background(FillAll(color: color))
    }
}

struct EntryListCustomHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListCustomHeaderView(sectionName: "section", color: Color.gray)
    }
}

struct FillAll:View {
    let color: Color
    
    var body: some View {
        GeometryReader{ proxy in
            self.color.frame(width: proxy.size.width * 1.1, height: proxy.size.height).fixedSize()}
    }
}
