//
//  AudioManager.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Speech
import SwiftUI

class AudioManager: NSObject, SFSpeechRecognizerDelegate {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let petNeeds = [                // mock translation data
        "I'm hungry, feed me.",
        "I need to go outside.",
        "Play with me!",
        "Let me sleep on your lap.",
        "Give me a treat.",
        "Clean my litter box.",
        "I want a belly rub.",
        "I'm scared, comfort me.",
        "Take me for a walk.",
        "Refill my water bowl.",
        "Open the window, I want to look outside.",
        "It's grooming time.",
        "I need attention.",
        "Don't leave me alone.",
        "Let me on the couch.",
        "I'm bored, entertain me.",
        "I want to chase something.",
        "Time for cuddles.",
        "Stop working, play with me instead."
    ]
    
     @Published var recognizedText = "" // if we need to use recognized audio

       func checkSpeechPermission(completion: @escaping (Bool) -> Void) {
           SFSpeechRecognizer.requestAuthorization { status in
               AVAudioApplication.requestRecordPermission { micStatus in
                   DispatchQueue.main.async {
                       switch status {
                       case .authorized:
                           if micStatus {
                               completion(true)
                           } else {
                               completion(false)
                           }
                       default:
                           completion(false)
                       }
                   }
               }

           }
       }
    
    func startTranscribing() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            AVAudioApplication.requestRecordPermission { micStatus in
                DispatchQueue.main.async {
                    guard authStatus == .authorized, micStatus == true else {
                        return
                    }
                    
                    self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                    guard let recognitionRequest = self.recognitionRequest else { return }
                    
                    let audioSession = AVAudioSession.sharedInstance()
                    do {
                        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                    } catch {
                        print("AVAudioSession error: \(error)")
                        return
                    }
                    
                    let inputNode = self.audioEngine.inputNode
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
                        self.recognitionRequest?.append(buffer)
                    }
                    
                    self.recognitionTask = self.speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                        if let result = result {
                            self.recognizedText = result.bestTranscription.formattedString
                        }
                        if error != nil || (result?.isFinal ?? false) {
                            self.audioEngine.stop()
                            inputNode.removeTap(onBus: 0)
                            self.recognitionRequest = nil
                            self.recognitionTask = nil
                        }
                    }
                    
                    do {
                        try self.audioEngine.start()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    func stopTranscribing() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}
