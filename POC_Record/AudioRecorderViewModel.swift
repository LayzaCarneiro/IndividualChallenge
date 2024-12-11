//
//  AudioRecorderViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 10/12/24.
//

import SwiftUI
import AVFoundation

class AudioRecorderViewModel: ObservableObject {
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    let fileName = "recordedAudio2.m4a"
    
    func startRecording() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            print("File exists at: \(fileURL.path)")
        } else {
            print("File does not exist.")
        }
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
            print("Recording started: \(fileURL)")
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        if let fileURL = audioRecorder?.url {
            print("Recording stopped. File saved at: \(fileURL.path)")
        } else {
            print("Recording stopped, but file URL is nil.")
        }
    }
    
    func getRecordedFileURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    func playRecordedAudio() {
        guard let fileURL = getRecordedFileURL() else {
            print("No file URL found.")
            return
        }
        
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("File does not exist at: \(fileURL.path)")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.play()
            print("Playing recorded audio: \(fileURL)")
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }
    
//    func playRecordedAudio() {
//        guard let fileURL = getRecordedFileURL() else { return }
//        do {
//            let audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
//            audioPlayer.play()
//            print("Playing recorded audio: \(fileURL)")
//        } catch {
//            print("Failed to play audio: \(error.localizedDescription)")
//        }
//    }
}
