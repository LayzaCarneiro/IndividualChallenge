//
//  RepeatWord.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI
import AVFoundation

struct RepeatSound: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var ExerciseVM: ExerciseViewModel

    @StateObject private var viewModel = SpeechRecognitionViewModel()
    @StateObject private var PhonoVM = PhonoTestViewModel()
    
    @State var phoneme: Phoneme
    @State var count: Int = 0
    
    @State private var isAnimating = false
    
    let maxProgress: CGFloat = 10.0
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            counter
                .padding()
            
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
            

//            RecordedLast(audioRecorder: audioRecorder)
//            
//            Spacer()
            
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
        .onChange(of: PhonoVM.prediction) { newPrediction, _ in
            if newPrediction == phoneme.letter {
                incrementCounter()
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
    }
    
    private var counter: some View {
        VStack(spacing: 30) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .foregroundColor(Color.gray.opacity(0.3)) // Fundo do círculo
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(count) / maxProgress)
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(-90)) // Começa do topo
                            .animation(.easeInOut(duration: 1.0), value: CGFloat(count)) // Animação suave
                        
                        Text("\(count)")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .foregroundColor(.blue)
                    }
                    .frame(width: 120, height: 120)
                }
                .padding()
        
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
        count += 1
    }
}
