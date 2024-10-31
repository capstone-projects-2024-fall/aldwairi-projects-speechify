//
//  NotecardDetail.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/26/24.
//

import SwiftUI

struct NotecardDetail: View {
    let notecard: Notecard
    
    
    var body: some View {
        
        
      //  onAppear(){
        //    Audio().initlizeRecordingSession()
          //  print("initilzied session sucessfully")
        //}
        VStack{
            Text(notecard.word)
                .font(.largeTitle)
            Text(notecard.phonetic).font(.largeTitle)
            AudioView()
           
        }
        
    }
}

struct NotecardDetail_Previews: PreviewProvider {
    static var previews: some View {
        NotecardDetail(notecard: Notecard(word: "", phonetic: "", category: "", favorite: "", audioPath: "", wordID: ""))

    }
                      
}
