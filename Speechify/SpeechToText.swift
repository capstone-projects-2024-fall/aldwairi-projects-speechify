import UIKit
import Speech
import AVKit
import Speech
import AVFoundation

class SpeechToText: ObservableObject {
    func transcribeAudio(url: URL) {
        let myRecognizer = SFSpeechRecognizer()
        let myRequest = SFSpeechURLRecognitionRequest(url: url)
        
        myRecognizer?.recognitionTask(with: myRequest) { (result, error) in
            guard let result = result else {
                print ("There was an error: \(error!)")
                return
            }
            if result.isFinal {
                print(result.bestTranscription.formattedString)
            }
            
        }
    }
}
