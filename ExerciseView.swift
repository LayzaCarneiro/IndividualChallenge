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

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("x")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                
                ProgressView(value: viewModel.progress)
                    .padding()
            }

            Text(viewModel.currentExercise.phoneme)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text(viewModel.currentExercise.description)
                .font(.title3)
                .padding(.bottom, 16)

            Spacer()

            Text(viewModel.currentStep)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            RepeatWord(audioRecorder: AudioRecorder())

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
