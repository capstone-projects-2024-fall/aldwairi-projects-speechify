//
//  ContentPage.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI

struct contentPageView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Speechify").font(.largeTitle).multilineTextAlignment(.center).padding(10)
                NavigationLink(destination: loginPageView()){
                    Text("Login").padding(5)
                }.buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).foregroundStyle(.blue).padding(10)
                NavigationLink(destination: signUpPageView()){
                    Text("Sign-Up").padding(5)
                }.buttonStyle(.bordered).buttonBorderShape(.roundedRectangle(radius: 5)).foregroundStyle(.blue).padding(10)
            }
        }
    }
}

#Preview {
    contentPageView()
}
