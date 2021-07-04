//
//  LoginView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 01.07.21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var loginViewController: LoginViewController
    @EnvironmentObject var userDatabase: UserDatabase
    @EnvironmentObject var entryDatabase: EntryDatabase
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                Spacer()
                
                Text("Email:")
                    .font(.callout)
                    .bold()
                
                TextField("Enter email...", text: $loginViewController.email)
                    .multilineTextAlignment(
                        .center)
                    .autocapitalization(.none)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                    .cornerRadius(20)
                
                Text("Password:")
                    .font(.callout)
                    .bold()
                
                SecureField("Enter password...", text: $loginViewController.password)
                    .multilineTextAlignment(
                        .center)
                    .autocapitalization(.none)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                    .cornerRadius(20)
               
                
                Spacer()
                
                Text(loginViewController.warning)
                    .bold()
                    .foregroundColor(.red)
                
                Button("Login!") {
                    loginViewController.login(userDatabase: userDatabase, entryDatabase: entryDatabase, contentViewController: contentViewController)
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                .cornerRadius(15.0)
                .fullScreenCover(isPresented: $contentViewController.homePageView, content: HomePageView.init)
                
                Button("Register!") {
                    loginViewController.navigateToRegistry(contentViewController: contentViewController)
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                .cornerRadius(15.0)
                .fullScreenCover(isPresented: $contentViewController.registryView, content: RegistryView.init)
                
                Spacer()
            }
            .navigationBarTitle("Login")
        }        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ContentViewController())
            .environmentObject(LoginViewController())
            .environmentObject(UserDatabase())
            .environmentObject(EntryDatabase())
    }
}
