//
//  PhonemeViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

class PhonemeViewModel: ObservableObject {
    @Published var phonemes: [Phoneme] = [
        Phoneme(symbol: "/ɪ/", description: "bit"),
        Phoneme(symbol: "/æ/", description: "cat"),
        Phoneme(symbol: "/ʌ/", description: "cup"),
        Phoneme(symbol: "/eɪ/", description: "cake"),
        Phoneme(symbol: "/aɪ/", description: "light"),
        Phoneme(symbol: "/θ/", description: "think"),
        Phoneme(symbol: "/ð/", description: "this"),
        Phoneme(symbol: "/s/", description: "sun"),
        Phoneme(symbol: "/ʃ/", description: "ship"),
        Phoneme(symbol: "/l/", description: "leaf"),
        Phoneme(symbol: "/r/", description: "red")
    ]
    
    func selectPhoneme(_ phoneme: Phoneme) {
        print("Selected phoneme: \(phoneme.symbol)")
    }
}
