//
//  Exercise.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI

struct ExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var phoneme: Phoneme

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        
                        Text("x")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                    }
                }
                
                ProgressView(value: viewModel.progress)
                    .progressViewStyle(ThickProgressViewStyle())
                    .animation(.easeInOut(duration: 0.5), value: viewModel.progress)
                    .padding()
            }

            Text(phoneme.symbol)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text(phoneme.description)
                .font(.title3)
                .padding(.bottom, 16)

            RepeatWord(audioRecorder: AudioRecorder(), ExerciseVM: viewModel, phoneme: phoneme)

            Spacer()

            Button {
                if viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 {
                    viewModel.goToNextStep()
                } else {
                    dismiss()
                }
            } label: {
                Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Next Step" : "Finish")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? Color.blue : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Step \(viewModel.currentStepIndex + 1)")
    }
}

struct ThickProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .scaleEffect(x: 1, y: 4, anchor: .center)
    }
}
