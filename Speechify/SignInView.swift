//
//  SignInView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/15/24.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var data: ReadData
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: NoteCardView(), label: {
                Text("Sign in!")
            })
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
