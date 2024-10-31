//
//  NotecardView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/31/24.
//

import SwiftUI

struct NotecardView: View {
    let category: String
    let notecards: [Notecard]
    
    @State var currentIndex: Int = 0
    
    var body: some View {
            VStack {
                
                //note card view
                VStack{
                    Text(notecards[currentIndex].word)
                        .font(.largeTitle)
                    Text(notecards[currentIndex].phonetic).font(.largeTitle)
                    Audio()
                   
                }
        
                
                //buttons
                HStack {
                    Button(action: previousNotecard) {
                        Text("Previous")
                            .padding()
                            .background(currentIndex == 0 ? Color.white : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(currentIndex == 0)
                    
                    Spacer()
                    
                    Button(action: nextNotecard) {
                        Text("Next")
                            .padding()
                            .background(currentIndex == notecards.count - 1 ? Color.white : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    .disabled(currentIndex == notecards.count - 1)
                }
                .padding(.top, 20)
            }
            .padding()
            //.navigationTitle("Notecard \(currentIndex + 1) of \(notecards.count)")
        }
    
    private func previousNotecard() {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
        
    private func nextNotecard() {
        if currentIndex < notecards.count - 1 {
            currentIndex += 1
        }
    }
}




