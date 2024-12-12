//
//  RepeatWord.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct RepeatWord: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @StateObject private var viewModel = SpeechRecognitionViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.recognizedText)
                .padding()
                .border(Color.gray)
            
//            RecordingsList(audioRecorder: audioRecorder)
            
            RecordedLast(audioRecorder: audioRecorder)
            
            Text("did")
                .font(.title)
                .fontWeight(.semibold)
            
            if audioRecorder.recording == false {
                Button {
                    self.audioRecorder.startRecording()
                    viewModel.startRecognition()
                } label: {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
            } else {
                Button {
                    self.audioRecorder.stopRecording()
                    viewModel.stopRecognition()
                } label: {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipped()
                        .foregroundColor(.red)
                        .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            viewModel.requestPermissions()
        }
        .padding()
    }
}
