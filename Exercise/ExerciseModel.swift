//
//  ExerciseModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct Exercise: Identifiable {
    let id = UUID()
    let phoneme: String
    let description: String
    let steps: [String] 
}
