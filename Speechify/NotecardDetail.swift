//
//  NotecardDetail.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/26/24.
//

import SwiftUI

struct NotecardDetail: View {
    let notecard: Notecard
    @EnvironmentObject var data: ReadData  // Access ReadData instance
    
    var body: some View {
        VStack {
            Text(notecard.word).font(.largeTitle)
            Text(notecard.phonetic).font(.largeTitle)
            AudioView()
            
        //favorit button
            Button(action: {
                data.toggleFavorite(notecard)
            }) {
                HStack {
                    Image(systemName: notecard.favorite == "true" ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                    Text(notecard.favorite == "true" ? "Remove from Favorites" : "Add to Favorites")
                }
            }
            .padding()
        }
        .onAppear {
            data.addToRecent(notecard)
        }
    }
}


struct NotecardDetail_Previews: PreviewProvider {
    static var previews: some View {
        NotecardDetail(notecard: Notecard(word: "", phonetic: "", favorite: "", audioPath: "", wordID: ""))
            .environmentObject(ReadData())
    }
                    
}

