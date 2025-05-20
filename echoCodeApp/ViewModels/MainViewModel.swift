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

@MainActor
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
    
    @Published var results: Bool? = false
    
    @Published var showAlert: Bool = false
    @Published var showRepeatButton: Bool = false
    @Published var headerText: HeaderOptions = .translate
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func onCloseButtonPressed() {
        recording = false
        results = false
        headerText = .translate
        showRepeatButton = false
    }
    
    func onSpeakButtonPressed() {
        withAnimation {
            if recording == true {
                recording = nil
                stopRecording()
                headerText = .result
                Task {
                    await processing()
                }
            } else if recording == false {
                startRecording()
            }
        }
    }
    
    private func startRecording() {
        recognizer.checkSpeechPermission { granted in
            if granted {
                self.recording = true
                self.recognizer.startTranscribing()
            } else {
                self.showAlert = true
            }
        }
    }
    
    func stopRecording() {
        recognizer.stopTranscribing()
        if fromHumanToPet {
            if dogIsSelected {
                recognizer.recognizedText = "Woof woof woof"
            } else {
                recognizer.recognizedText = "Mew mew mew"
            }
        } else {
            recognizer.recognizedText = recognizer.petNeeds.randomElement() ?? ""
        }
    }
    
    private func processing() async {
        results = nil
        try? await Task.sleep(for: .seconds(2))
        if recording != false {
            results = true
        }
    }
    
}
