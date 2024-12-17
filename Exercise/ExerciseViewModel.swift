//
//  ExerciseViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = [
        Exercise(phoneme: "/s/", description: "Practice the 's' sound", steps: ["Step 1: Repeat 10 times the sound", "Step 2: Repeat 'snake'"]),
        Exercise(phoneme: "/æ/", description: "Practice the short 'a' sound", steps: ["Step 1: Say 'cat'", "Step 2: Repeat 5 times"]),
    ]
    
    @Published var currentExerciseIndex: Int = 0
    @Published var currentStepIndex: Int = 0

    var currentExercise: Exercise {
        exercises[currentExerciseIndex]
    }

    var currentStep: String {
        currentExercise.steps[currentStepIndex]
    }

    var progress: Double {
        Double(currentStepIndex + 1) / Double(currentExercise.steps.count)
    }

    func goToNextStep() {
        if currentStepIndex < currentExercise.steps.count - 1 {
            currentStepIndex += 1
        }
    }

    func resetSteps() {
        currentStepIndex = 0
    }
}
