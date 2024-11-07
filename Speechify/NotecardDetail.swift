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
    @StateObject private var ttsManager = TextToSpeechManager()
    
    // Add this computed property to get the current state of the notecard
    private var currentNotecard: Notecard {
        if let updatedCard = data.notecards.first(where: { $0.wordID == notecard.wordID }) {
            return updatedCard
        }
        return notecard
    }
    
    var body: some View {
        VStack {
            Text(notecard.word).font(.largeTitle)
            Text(notecard.phonetic).font(.largeTitle)
            
            Button(action: {
                ttsManager.speak(word: notecard.word)
            }){
                Image(systemName: "speaker.wave.2.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding()
            
            AudioView()
            
        //favorite button
            Button(action: {
                data.toggleFavorite(currentNotecard)
            }) {
                HStack {
                    Image(systemName: currentNotecard.favorite == "true" ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                    Text(notecard.favorite == "true" ? "Remove from Favorites" : "Add to Favorites")
                }
            }
            .padding()
            .padding(.bottom, 10)
        }
        .padding()
        .onAppear {
            data.addToRecent(currentNotecard)
        }
    }
}


 
 struct NotecardDetail_Previews: PreviewProvider {
 static var previews: some View {
 NotecardDetail(notecard: Notecard(word: "", phonetic: "", favorite: "", audioPath: "", wordID: ""))
 .environmentObject(ReadData())
 }
 
 }
 
 
