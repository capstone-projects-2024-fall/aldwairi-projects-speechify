//
//  SpeechifyApp.swift
//  Speechify
//
//  Created by Oladapo Emmanuel Oladele on 10/24/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        FirebaseApp.configure()
        return true
    }
}

@main
struct SpeechifyApp: App{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene{
        WindowGroup{
            contentPageView()
        }
    }
}
