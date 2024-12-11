//
//  AudioRecorderView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 10/12/24.
//
//
//import SwiftUI
//
//struct AudioRecorderView: View {
//    @StateObject private var audioRecorderViewModel = AudioRecorderViewModel()
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Button(action: {
//                if audioRecorderViewModel.isRecording {
//                    audioRecorderViewModel.stopRecording()
//                } else {
//                    audioRecorderViewModel.startRecording()
//                }
//            }) {
//                Image(systemName: audioRecorderViewModel.isRecording ? "stop.circle" : "mic.circle")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//                    .foregroundColor(audioRecorderViewModel.isRecording ? .red : .blue)
//            }
//            
//            if let recordedURL = audioRecorderViewModel.recordedAudioURL {
//                Text("Gravação salva em:")
//                Text(recordedURL.lastPathComponent)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//    }
//}

import SwiftUI

struct AudioRecorderView: View {
    @StateObject var audioRecorderViewModel = AudioRecorderViewModel()
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recordedAudio2.m4a").path
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                if audioRecorderViewModel.isRecording {
                    audioRecorderViewModel.stopRecording()
                } else {
                    audioRecorderViewModel.startRecording()
                }
            }) {
                Text(audioRecorderViewModel.isRecording ? "Stop Recording" : "Start Recording")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(audioRecorderViewModel.isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                if audioPlayerViewModel.audioPlayer == nil {
                    audioPlayerViewModel.loadAudio(fromPath: filePath)
                }
                audioPlayerViewModel.playOrPause()
            }) {
                Image(systemName: audioPlayerViewModel.isPlaying ? "pause.circle" : "play.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
        }
        .onAppear {
            audioPlayerViewModel.loadAudio(fromPath: filePath)
            
            print("File path: \(filePath)")
            let fileExists = FileManager.default.fileExists(atPath: filePath)
            print("File exists: \(fileExists)")
            
            if fileExists {
                audioPlayerViewModel.loadAudio(fromPath: filePath)
            } else {
                print("Audio file does not exist at the specified path.")
            }
        }
        .padding()
    }
}
