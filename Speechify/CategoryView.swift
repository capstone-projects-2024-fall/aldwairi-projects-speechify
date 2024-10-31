//
//  CategoryView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/31/24.
//

import SwiftUI



struct CategoryView: View {
    let category: String
    let notecards: [Notecard]
    
    var body: some View {
        List(notecards) { notecard in
            VStack(alignment: .leading) {
                Text(notecard.word)
                    .font(.headline)
                Text(notecard.phonetic)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(category.capitalized)
    }
}


