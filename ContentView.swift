//
//  ContentView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var audioRecorder = AudioRecorderViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                if audioRecorder.isRecording {
                    audioRecorder.stopRecording()
                } else {
                    audioRecorder.startRecording()
                }
            }) {
                Text(audioRecorder.isRecording ? "Stop Recording" : "Start Recording")
                    .padding()
                    .foregroundColor(.white)
                    .background(audioRecorder.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                audioRecorder.playRecordedAudio()
            }) {
                Text("Play Recorded Audio")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            if let recordedFileURL = audioRecorder.getRecordedFileURL() {
                Text("Recorded File: \(recordedFileURL.lastPathComponent)")
                    .font(.footnote)
                    .padding()
            }
        }
        .padding()
    }
}
