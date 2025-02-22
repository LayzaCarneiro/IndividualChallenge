//
//  ExerciseViews.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct ExerciseListView: View {
    @State private var isShowConfirmEndExercise = false

    let phoneme: Phoneme

    var body: some View {
        VStack {
            Button {
                isShowConfirmEndExercise.toggle()
            } label: {
                Text("exit")
                    .font(.largeTitle)
            }
            
            Text("Exercises for \(phoneme.symbol)")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            List {
                Text("Exercise 1")
                Text("Exercise 2")
            }
        }
        .navigationTitle("Exercises")
    }
}

struct StepDetailView: View {
    @ObservedObject var viewModel: ExerciseViewModel

    var body: some View {
        VStack {
            ProgressView(value: viewModel.progress)
                .padding()

            Text(viewModel.currentExercise.phoneme)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)

            Text(viewModel.currentExercise.description)
                .font(.title3)
                .padding(.bottom, 16)

            Spacer()

            Button {
                viewModel.goToNextStep()
            } label: {
                Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Next Step" : "Finish")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? Color.blue : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(viewModel.currentStepIndex == viewModel.currentExercise.steps.count - 1)
        }
        .navigationTitle("Step \(viewModel.currentStepIndex + 1)")
    }
}

extension ExerciseListView {
    init(for phoneme: Phoneme) {
        self.phoneme = phoneme
    }
}
