//
//  ContentView.swift
//  8_UI
//
//  Created by Amy Ollomani on 10/29/24.
//

import SwiftUI
import AVKit

struct AudioView: View {
    var body: some View {
        Audio()
    }
}

struct Audio : View {
    
    @State var record = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var audioPlayer: AVAudioPlayer!
    @State var alert = false
    @State var count = 0
    @State private var latestRecordingURL: URL? //For other files to access the recording
    
    //fetch audio
    @State var audios: [URL] = []
    //removing old data from app
    
    
    var body : some View {
        NavigationView{
            VStack
            {
                
               
                Button(action:{
                    playAudio()
                }){
                    Text("Press to play audio")
                }
                Button(action: {
                    
                    do{
                        if self.record{
                            //button is already clicked: so this if statment is handling stopping the recording
                            self.recorder.stop()
                            self.latestRecordingURL = self.recorder.url //store recording
                            self.record.toggle()
                            self.getAudios()
                            return
                        }
                        //record audio when preced
                        //store audio in direcotry
                        //gets path to user directory
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        //appends filename to recording
                        let fileName = url.appendingPathComponent("recording.m4a")
                        
                        //audio settings (audio clarity)
                        let settings = [
                            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey: 12000,
                            AVNumberOfChannelsKey: 1,
                            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                        ]
                        self.recorder = try AVAudioRecorder(url: fileName,settings: settings)
                        self.recorder.record()
                        self.record.toggle()
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    
                }){
                    ZStack{
                        Circle().fill(Color.red)
                            .frame(width: 70, height: 70)
                        if self.record{
                            Circle()
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 55, height: 55)
                        }
                    }
                    
                }
                .padding(.vertical, 25)
            }
          
        }
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text ("Error"), message: Text("Enable Acess"))
        })
        .onAppear(){
            do{
                //Initializing
                
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                //requesting permission
                if #available(iOS 17.0, *) {
                    AVAudioApplication.requestRecordPermission { granted in
                        if granted {
                            print("Microphone access granted.")
                            // Proceed with microphone-related tasks
                            //Updating audio for each recording
                            self.getAudios()
                        } else {
                            print("Microphone access denied.")
                            self.alert.toggle()
                            // Handle denial, perhaps alert the user or restrict microphone functionality
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
                    
                
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudios(){
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in:
                    .userDomainMask)[0]
            
            //fetch all data from document directory
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            //removing old data
            self.audios.removeAll()
            
            //update with new recording
            for i in result{
                self.audios.append(i)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    //Play most recent recording
    func playAudio(){
        let path = self.audios[0]
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
                audioPlayer.play()
        }catch{
            
        }
        
    }
    
    func getLatestRecordingURL() -> URL? {
        return latestRecordingURL
    }
}

#Preview {
    AudioView()
}
