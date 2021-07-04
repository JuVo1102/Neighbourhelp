//
//  RegistryView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct RegistryView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var registryViewController: RegistryViewController
    @EnvironmentObject var userData: UserDatabase
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                Spacer()
                
                CustomRegistryTextFieldView()               
                
                Spacer()
                
                Text(registryViewController.warning)
                    .bold()
                    .foregroundColor(.red)
                
                Button("Register!") {
                    registryViewController.register(userdataBase: userData, contentViewController: contentViewController)
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                .cornerRadius(15.0)
                .fullScreenCover(isPresented: $contentViewController.homePageView, content: HomePageView.init)
                
                Button("Back") {
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                .cornerRadius(15.0)
                
                Spacer()
            }
            .navigationBarTitle("Registry")
        } 
    }
}

struct RegistryView_Previews: PreviewProvider {
    static var previews: some View {
        RegistryView()
            .environmentObject(ContentViewController())
            .environmentObject(RegistryViewController())
            .environmentObject(UserDatabase())
    }
}
