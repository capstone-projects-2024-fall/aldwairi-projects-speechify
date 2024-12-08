//
//  AudioPlayerDelegateTests.swift
//  Speechify
//
//  Created by Emily Jarosiewicz on 12/7/24.
//

import XCTest
import AVFoundation
@testable import Speechify

class AudioPlayerDelegateTests: XCTestCase, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer?
    var playbackCompletionCalled: Bool = false
    var decodingErrorHandled: Bool = false
    var decodingError: Error?

    override func setUp() {
        super.setUp()
        playbackCompletionCalled = false
        decodingErrorHandled = false
        decodingError = nil

        let bundle = Bundle(for: type(of: self)) // Access the test bundle
        if let fileURL = bundle.url(forResource: "test_audio", withExtension: "m4a") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
                audioPlayer?.delegate = self // Assign self as delegate
            } catch {
                XCTFail("Failed to initialize AVAudioPlayer with test audio file: \(error)")
            }
        } else {
            XCTFail("Test audio file not found in test bundle")
        }
    }

    override func tearDown() {
        audioPlayer = nil
        super.tearDown()
    }

    // MARK: - Test: Playback Completion Handling
    func testAudioPlayerDidFinishPlaying() {
        guard let audioPlayer = audioPlayer else {
            XCTFail("Audio player is not initialized")
            return
        }

        // Simulate playback finished
        self.audioPlayerDidFinishPlaying(audioPlayer, successfully: true)

        // Assert completion event handled
        XCTAssertTrue(playbackCompletionCalled, "Playback completion should be handled")
    }

    // MARK: - Test: Decoding Error Handling
    func testAudioPlayerDecodeErrorDidOccur() {
        guard let audioPlayer = audioPlayer else {
            XCTFail("Audio player is not initialized")
            return
        }

        // Create a mock error
        let mockError = NSError(domain: "AudioPlayerErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])

        // Simulate decoding error
        self.audioPlayerDecodeErrorDidOccur(audioPlayer, error: mockError)

        // Assert error handling
        XCTAssertTrue(decodingErrorHandled, "Decoding error should be handled")
        XCTAssertEqual(decodingError?.localizedDescription, "Decoding failed", "Error description should match")
    }

    // MARK: - AVAudioPlayerDelegate Methods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playbackCompletionCalled = true
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        decodingErrorHandled = true
        decodingError = error
    }
}

