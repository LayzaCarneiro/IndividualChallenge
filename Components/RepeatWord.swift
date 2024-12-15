////
////  RepeatWord.swift
////  Speeches
////
////  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
////
//
//import SwiftUI
//import AVKit
//import AVFoundation
//
//struct RepeatWord: View {
//    @ObservedObject var audioRecorder: AudioRecorder
//    @StateObject private var viewModel = SpeechRecognitionViewModel()
//    
//    var body: some View {
//        VStack {
//            Text("did")
//                .font(.title)
//                .fontWeight(.semibold)
//            
//            // play audio
//            
//            Text(viewModel.recognizedText)
//                .padding()
//                .border(Color.gray)
//            
////            RecordingsList(audioRecorder: audioRecorder)
//            
//            RecordedLast(audioRecorder: audioRecorder)
//            
//            if audioRecorder.recording == false {
//                Button {
//                    self.audioRecorder.startRecording()
//                    viewModel.startRecognition()
//                } label: {
//                    Image(systemName: "circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 70, height: 70)
//                        .clipped()
//                        .foregroundColor(.red)
//                        .padding(.bottom, 40)
//                }
//            } else {
//                Button {
//                    self.audioRecorder.stopRecording()
//                    viewModel.stopRecognition()
//                } label: {
//                    Image(systemName: "stop.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 70, height: 70)
//                        .clipped()
//                        .foregroundColor(.red)
//                        .padding(.bottom, 40)
//                }
//            }
//        }
//        .onAppear {
//            viewModel.requestPermissions()
//        }
//        .padding()
//    }
//}

import SwiftUI
import AVKit
import AVFoundation

struct RepeatWord: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @StateObject private var viewModel = SpeechRecognitionViewModel()
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("snake")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Button {
                playAudio()
            } label: {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 10)
            
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
    
    private func playAudio() {
        isPlaying.toggle()
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
