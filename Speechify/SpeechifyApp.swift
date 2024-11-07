//
//  SpeechifyApp.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

@main
// testing

struct SpeechifyApp: App {
    @StateObject private var data = ReadData()
    
    var body: some Scene {
        WindowGroup {
            SignInView()
                .environmentObject(data)
           // NoteCardView()
        }
    }
}
