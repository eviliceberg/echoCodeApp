//
//  AudioManager.swift
//  echoCodeApp
//
//  Created by Artem Golovchenko on 2025-05-19.
//

import Speech
import SwiftUI

class AudioManager: NSObject, SFSpeechRecognizerDelegate {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "uk-UA"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @Published var recognizedText = ""

       func checkSpeechPermission(completion: @escaping (Bool) -> Void) {
           SFSpeechRecognizer.requestAuthorization { status in
               DispatchQueue.main.async {
                   switch status {
                   case .authorized:
                       completion(true)
                   default:
                       completion(false)
                   }
               }
           }
       }
    
    func startTranscribing() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                guard authStatus == .authorized else {
                    print("Speech не дозволено")
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
                    print("🎤 Розпізнавання розпочато")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func stopTranscribing() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        print("⏹ Розпізнавання зупинено")
    }
}
