//
//  CreateEntryView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 02.07.21.
//

import SwiftUI

struct CreateEntryView: View {
    @EnvironmentObject var contentViewController: ContentViewController
    @EnvironmentObject var createEntryController: CreateEntryViewController
    @EnvironmentObject var entryListViewController: EntryListViewController
    @EnvironmentObject var userDatabase: UserDatabase
    @EnvironmentObject var entryDatabase: EntryDatabase
    
    var body: some View {
        NavigationView {
            VStack (spacing: 8.0) {
                Spacer()
                
                Text(createEntryController.warning)
                    .bold()
                    .foregroundColor(.red)
                
                Text("Title:")
                    .font(.callout)
                    .bold()
                
                TextField("Enter Title...", text: $createEntryController.title)
                    .multilineTextAlignment(
                        .center)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                    .cornerRadius(20)
                
                Text("Description:")
                    .font(.callout)
                    .bold()
                
                TextEditor(text: $createEntryController.description)
                    .multilineTextAlignment(
                        .leading)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                    .cornerRadius(20)
                
                Spacer()
                
                Button(action: {createEntryController.addEntryToDatabase(
                    entryDatabase: entryDatabase,
                    userDatabase: userDatabase,
                    contentViewController: contentViewController
                )}){
                    Text("Create Request")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
                        .cornerRadius(15.0)                        
                }
                Spacer()
            }
            .onDisappear {
                entryDatabase.getData(user: userDatabase.currentUser)
                entryListViewController.queryEntries(entryDatabase: entryDatabase, userDatabase: userDatabase)
            }            
            .navigationBarTitle("Create Request")
            .navigationBarItems(
                trailing:
                    HStack{
                        Text("Logout: ")
                            .foregroundColor(.black)
                        Button("\(userDatabase.currentUser.email)") {
                            userDatabase.logout()
                            contentViewController.navigateToLogin()
                        }
                    }
            )
        }
    }
}


struct CreateEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEntryView()
            .environmentObject(ContentViewController())
            .environmentObject(CreateEntryViewController())
            .environmentObject(EntryListViewController())
            .environmentObject(UserDatabase())
            .environmentObject(EntryDatabase())
    }
}
