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
    @StateObject private var PhonoVM = PhonoTestViewModel()
    
    @State var phoneme: Phoneme
    @State var counter: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(ExerciseVM.currentStep)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                        
            RecordingRow(audioURL: Bundle.main.url(forResource: phoneme.soundFile, withExtension: "m4a")!)
            
            Text("\(counter)")
                .font(.title)
            
//            VStack {
//                Text("Recognized Text")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                Text(viewModel.recognizedText.isEmpty ? "..." : viewModel.recognizedText)
//                    .font(.title3)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(8)
//            }
            
            Spacer()

            RecordedLast(audioRecorder: audioRecorder)
            
            Spacer()
            
            if let prediction = PhonoVM.prediction {
                Text("Previsão: \(prediction)")
                    .font(.headline)
            }
                            
            Button {
                PhonoVM.toggleRecording()
            } label: {
                ZStack {
                    Circle()
                        .fill(PhonoVM.isRecording ? Color.red.opacity(0.3) : Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .scaleEffect(PhonoVM.isRecording ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: PhonoVM.isRecording)
                    
                    Image(systemName: PhonoVM.isRecording ? "stop.fill" : "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(PhonoVM.isRecording ? .red : .blue)
                }
            }
            .disabled(PhonoVM.isProcessing)
            
            
        }
        .onAppear {
            viewModel.requestPermissions()
        }
        .onChange(of: PhonoVM.prediction) { newPrediction in
            if newPrediction == phoneme.letter {
                incrementCounter()
            }
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
    
    func incrementCounter() {
        counter += 1
    }
}
