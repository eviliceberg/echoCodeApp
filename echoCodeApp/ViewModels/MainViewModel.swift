//
//  MainViewModel.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Foundation
import SwiftUI

enum HeaderOptions: String {
    case translate
    case result
    case settings
}

final class MainViewModel: ObservableObject {
    
    let settingOption: [Setting] = [
            Setting(title: "Rate Us", destination: AnyView(Text("Rate Us"))),
            Setting(title: "Share App", destination: AnyView(Text("Share App"))),
            Setting(title: "Contact Us", destination: AnyView(Text("Contact Us Page"))),
            Setting(title: "Restore Purchases", destination: AnyView(Text("Restore Page"))),
            Setting(title: "Privacy Policy", destination: AnyView(Text("Privacy Policy Page"))),
            Setting(title: "Terms of Use", destination: AnyView(Text("Terms of Use Page")))
        ]
    
    let recognizer = AudioManager()
    
    @Published var fromHumanToPet = true
    @Published var dogIsSelected: Bool = true
    
    @Published var recording: Bool? = false
    @Published var selectedMainScreen: Bool = true
    
    @Published var results: Bool = false
    
    @Published var showAlert: Bool = false
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func startRecording() {
        recognizer.checkSpeechPermission { granted in
            if granted {
                self.recognizer.startTranscribing()
            } else {
                self.showAlert = true
            }
        }
    }
    
    func stopRecording() {
        recognizer.stopTranscribing()
    }
    
}
