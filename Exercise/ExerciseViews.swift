//
//  ExerciseViews.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

//struct ExerciseListView: View {
//    @StateObject private var viewModel = ExerciseViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            List(viewModel.exercises.indices, id: \.self) { index in
//                NavigationLink(
//                    destination: StepDetailView(viewModel: viewModel)
//                        .onAppear {
//                            viewModel.currentExerciseIndex = index
//                            viewModel.resetSteps()
//                        },
//                    label: {
//                        Text(viewModel.exercises[index].phoneme)
//                            .font(.headline)
//                    }
//                )
//            }
//            .navigationTitle("Phoneme Exercises")
//        }
//    }
//}

struct ExerciseListView: View {
    let phoneme: Phoneme

    var body: some View {
        VStack {
            Text("Exercises for \(phoneme.symbol)")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            // Exemplo: exiba uma lista de exercícios aqui
            List {
                Text("Exercise 1")
                Text("Exercise 2")
                // Adicione mais exercícios conforme necessário
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

            Text(viewModel.currentStep)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

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
