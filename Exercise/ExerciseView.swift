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
    @State private var isShowFeedback = false
    @State var isShowConfirmSkipStep = false
    @State private var isExpanded = false

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
            seeTips
            
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
            
            nextStepButton
        }
    }
    
    private var phonemeTutorial: some View {
        VStack(alignment: .leading) {
            Text("How to make the sound")
                .font(.system(size: 24, weight: .bold))
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("offWhite"))
                .stroke(.black)
                .frame(width: 540, height: 260)
                .overlay(
                    MiniVideoView(phoneme: phoneme)
                )
        }
    }
    
    private var seeTips: some View {
        VStack {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("See tips")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            
            if isExpanded {
                ScrollView {
                    VStack(alignment: .leading) {
                        TipComponent(tip: phoneme.tips[0])
                        TipComponent(tip: phoneme.tips[1])
                        TipComponent(tip: phoneme.tips[2])
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .padding()
        
    }
    
    private var nextStepButton: some View {
        Button {
            isShowConfirmSkipStep.toggle()
        } label: {
            Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip" : "Finish")
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? Color.blue : Color.green)
                .clipShape(Capsule())
        }
        
        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: viewModel.currentStepIndex)
        .alert(isPresented: $isShowConfirmSkipStep) {
                Alert(
                    title: Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip Step" : "Finish Exercise"),
                    message: Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ?
                                  "Are you sure you want to skip this step?" :
                                  "Are you sure you want to finish the exercise?"),
                    primaryButton: .destructive(Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip" : "Finish")) {
                        if viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 {
                            viewModel.goToNextStep()
                        } else {
                            isShowFeedback.toggle()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        .sheet(isPresented: $isShowFeedback) {
            FeedbackView(isExerciseViewPresented: $isPresented, phoneme: phoneme)
        }

    }
}

struct ThickProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .scaleEffect(x: 1, y: 4, anchor: .center)
    }
}

