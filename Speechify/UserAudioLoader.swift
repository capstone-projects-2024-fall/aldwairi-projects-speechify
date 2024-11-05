//
//  UserAudioLoader.swift
//  Speechify
//
//  Created by Timothy Andrei Baciu on 11/4/24.
//

import Foundation
import AVFoundation

class UserAudioLoader {
    static let shared = UserAudioLoader()
    private init() {}
    
    // Retrieve the latest recording URL from RecordAudio.swift
    func loadUserAudio() -> URL? {
        guard let audioURL = Audio().getLatestRecordingURL() else {
            print("No recent audio found.")
            return nil
        }
        return audioURL
    }

    // Convert audio to PCM buffer for analysis
    func convertAudioToPCMBuffer(url: URL) -> AVAudioPCMBuffer? {
        do {
            let audioFile = try AVAudioFile(forReading: url)
            let format = audioFile.processingFormat
            let frameCount = UInt32(audioFile.length)
            
            guard let pcmBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
                print("Failed to create PCM buffer.")
                return nil
            }
            
            try audioFile.read(into: pcmBuffer)
            return pcmBuffer
        } catch {
            print("Error reading audio file: \(error)")
            return nil
        }
    }
    
    // Example function for loading and processing user audio
    func analyzeUserAudio() {
        guard let audioURL = loadUserAudio() else {
            print("Audio loading failed.")
            return
        }
        
        guard let pcmBuffer = convertAudioToPCMBuffer(url: audioURL) else {
            print("Failed to convert audio to PCM buffer.")
            return
        }
        
        // Placeholder for further phonetic analysis logic
        print("Successfully loaded and converted audio for analysis.")
        // You can now process pcmBuffer for phonetic analysis
    }
}
