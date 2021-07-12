//
//  CustomRegistryTextFieldView.swift
//  Neighbourhelp
//
//  Created by Julian Vorbink on 03.07.21.
//

import SwiftUI

// Basically a substitute to fit in all UIElements i needed for the RegistryView since a View can only handle around 10-11 subViews / "viewItems"

struct CustomRegistryTextFieldView: View {
    @EnvironmentObject var registryViewController: RegistryViewController
    var body: some View {        
        
        Text("Email:")
            .font(.callout)
            .bold()
        
        TextField("Enter email...", text: $registryViewController.email)
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
        
        SecureField("Enter password...", text: $registryViewController.password)
            .multilineTextAlignment(
                .center)
            .font(.headline)
            .autocapitalization(.none)
            .foregroundColor(.black)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
            .cornerRadius(20)
        
        Text("Confirm password:")
            .font(.callout)
            .bold()
        
        SecureField("Confirm password...", text: $registryViewController.confirmPassword)
            .multilineTextAlignment(
                .center)
            .font(.headline)
            .autocapitalization(.none)
            .foregroundColor(.black)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color(hue: 1.0, saturation: 0.028, brightness: 0.864))
            .cornerRadius(20)
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRegistryTextFieldView()
            .environmentObject(ContentViewController())
    }
}
