//
//  Exercise.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI

struct ExerciseView: View {
    @StateObject var viewModel = ExerciseViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    @State private var isShowConfirmEndExercise = false

    let phoneme: Phoneme
    
    var body: some View {
        ZStack {
            Color("offWhite").ignoresSafeArea()
            
            VStack(spacing: 20) {
                progressView
                
                if viewModel.currentStepIndex == 0 {
                    exerciseViewOne
                } else {
                    exerciseViewTwo
                }
                
                Spacer()
                
                nextStepButton
            }
        }
        .padding()
    }
    
    private var exerciseViewOne: some View {
        VStack(spacing: 20) {
            Text("Step 1: Repeat 10 times the sound \(phoneme.symbol)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            phonemeTutorial
            
            RepeatSound(audioRecorder: AudioRecorder(), ExerciseVM: viewModel, phoneme: phoneme)
        }
    }
    
    private var exerciseViewTwo: some View {
        VStack(spacing: 20) {
            Text("Step 2: Repeat the following words")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            ForEach(phoneme.words, id: \.self) { word in
                Text(word)
            }
            
            RepeatSound(audioRecorder: AudioRecorder(), ExerciseVM: viewModel, phoneme: phoneme)
        }
    }
    
    private var progressView: some View {
        HStack {
            Button {
                isShowConfirmEndExercise.toggle()
            } label: {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text("X")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                    )
            }
            .alert("End practice", isPresented: $isShowConfirmEndExercise) {
                Button("Cancel", role: .cancel) {
                }
                Button("End", role: .destructive) {
                    isPresented.toggle()
                }
            } message: {
                Text("Are you sure you want to end the practice session?")
            }
            
            ProgressView(value: viewModel.progress)
                .progressViewStyle(ThickProgressViewStyle())
                .animation(.easeInOut(duration: 0.5), value: viewModel.progress)
                .padding()
        }
    }
    
    private var phonemeTutorial: some View {
        VStack(alignment: .leading) {
            Text("How to make the sound")
                .font(.system(size: 24, weight: .bold))
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("offWhite"))
                .stroke(.black)
                .frame(width: 540, height: 220)
                .overlay(
                    MiniVideoView(phoneme: phoneme)
                        .padding(.top, 30)
                )
        }
    }
    
    private var nextStepButton: some View {
        Button {
            if viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 {
                viewModel.goToNextStep()
            } else {
                dismiss() // TODO:
            }
        } label: {
            Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Next Step" : "Finish")
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? Color.blue : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct ThickProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .scaleEffect(x: 1, y: 4, anchor: .center)
    }
}

