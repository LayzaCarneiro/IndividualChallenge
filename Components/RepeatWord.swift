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
    @ObservedObject var PhonoVM: PhonoTestViewModel //Changed StateObject to ObservedObject
    @StateObject private var viewModel = SpeechRecognitionViewModel()

    @State var phoneme: Phoneme
    
    @State private var isAnimating = false
        
    let maxProgress: CGFloat = 3.0
    init(audioRecorder: AudioRecorder, ExerciseVM: ExerciseViewModel, phoneme: Phoneme) {
        self.audioRecorder = audioRecorder
        self.ExerciseVM = ExerciseVM
        self._phoneme = State(initialValue: phoneme)
        self.PhonoVM = PhonoTestViewModel(targetClass: phoneme.letter)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            if let prediction = PhonoVM.predictedClass {
                if prediction {
                    Text("Very good!! ")
                        .font(.title2)
                        .fontWeight(.bold)                    .foregroundStyle(.black)
                } else {
                    Text("Try again!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
            }
            
            counter
                .padding()
            
            Button {
                PhonoVM.toggleRecording()
            } label: {
                ZStack {
                    Circle()
                        .fill(PhonoVM.isRecording ? Color.red.opacity(0.3) : Color.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .stroke(PhonoVM.isRecording ? Color.red : Color.blue, lineWidth: 4)
                                .scaleEffect(PhonoVM.isRecording ? 1.3 : 1.0)
                                .opacity(PhonoVM.isRecording ? 0.6 : 0.8)
                        )
                    
                    Image(systemName: PhonoVM.isRecording ? "stop.fill" : "mic.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Circle().fill(PhonoVM.isRecording ? Color("darkOrange") : Color.blue).frame(width: 80, height: 80))
                        .shadow(color: PhonoVM.isRecording ? Color("darkOrange").opacity(0.7) : .blue.opacity(0.5), radius: 8)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(PhonoVM.isProcessing)
        }
        .onAppear {
            viewModel.requestPermissions()
        }

        .onChange(of: PhonoVM.count) { newCount, _ in
            if newCount >= Int(maxProgress) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    ExerciseVM.currentStepIndex += 1
                }
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
                    .trim(from: 0.0, to: CGFloat(PhonoVM.count) / maxProgress) //Binded to PhonoVM.count
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90)) // Começa do topo
                    .animation(.easeInOut(duration: 1.0), value: CGFloat(PhonoVM.count)) // Animação suave
                
                Text("\(PhonoVM.count)") //Display PhonVM.count
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
            }
            .frame(width: 120, height: 120)
        }
        .padding()
        
    }
}
