//
//  SelectionView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var viewController: ContentViewController
    @State var selection = 0
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack ( spacing: 30) {
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .fullScreenCover(isPresented: $showingSheet, content: LoginView.init)
            }
            
            
            
            /*NavigationLink(
             destination: LoginView(),
             isActive: $viewController.loginView)
             { EmptyView() }
             Text("SelectionView")
             Button("Toggle Full Screen") {
             viewController.fullScreen.toggle()
             }
             Button("Go to Login") {
             viewController.loginView.toggle()
             }
             }
             .navigationBarTitle("", displayMode: .inline)
             .navigationBarBackButtonHidden(true)
             .navigationBarHidden(viewController.fullScreen)*/
        }
        .statusBar(hidden: viewController.fullScreen)
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
            .environmentObject(ContentViewController())
    }
}
