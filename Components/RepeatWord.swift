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
    @ObservedObject var ExerciseVM: ExerciseViewModel

    @StateObject private var viewModel = SpeechRecognitionViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(ExerciseVM.currentStep)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            playSound()
            
            VStack {
                Text("Recognized Text")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(viewModel.recognizedText.isEmpty ? "..." : viewModel.recognizedText)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            
            Spacer()
            
            RecordedLast(audioRecorder: audioRecorder)
            
            Spacer()
            
            Button {
                if audioRecorder.recording {
                    stopRecording()
                } else {
                    startRecording()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(audioRecorder.recording ? Color.red.opacity(0.3) : Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .scaleEffect(audioRecorder.recording ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: audioRecorder.recording)
                    
                    Image(systemName: audioRecorder.recording ? "stop.fill" : "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(audioRecorder.recording ? .red : .blue)
                }
            }
        }
        .onAppear {
            viewModel.requestPermissions()
        }
        .padding()
        .frame(maxHeight: .infinity)
    }
    
    private func startRecording() {
        audioRecorder.startRecording()
        viewModel.startRecognition()
    }
    
    private func stopRecording() {
        audioRecorder.stopRecording()
        viewModel.stopRecognition()
    }
}
