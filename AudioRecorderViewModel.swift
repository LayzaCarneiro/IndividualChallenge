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
    
    let fileName = "recordedAudio.m4a"
    
    func startRecording() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
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
        print("Recording stopped.")
    }
    
    func getRecordedFileURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    }
    
    func playRecordedAudio() {
        guard let fileURL = getRecordedFileURL() else { return }
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer.play()
            print("Playing recorded audio: \(fileURL)")
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }

}
