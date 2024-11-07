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
    @StateObject private var sttManager = SpeechToText()
    @State private var audioURL = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
    
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
            Button(action: {
                sttManager.transcribeAudio(url: audioURL)
            }){
                Image(systemName: "square").font(.system(size: 40))
                    .foregroundColor(.blue)
            }
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

