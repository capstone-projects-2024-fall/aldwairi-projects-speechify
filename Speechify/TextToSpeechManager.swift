//
//  TextToSpeechManager.swift
//  Speechify
//
//  Created by Timothy Andrei Baciu on 10/31/24.
//

import AVFoundation

class TextToSpeechManager: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // Adjust the rate as needed
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
