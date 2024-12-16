//
//  PhonemeViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

class PhonemeViewModel: ObservableObject {
    @Published var phonemes: [Phoneme] = [
        Phoneme(symbol: "/ʃ/", description: "ship"),
        Phoneme(symbol: "/s/", description: "sun"),
        Phoneme(symbol: "/θ/", description: "think"),
        Phoneme(symbol: "/ð/", description: "this"),
        Phoneme(symbol: "/r/", description: "red"),
        Phoneme(symbol: "/l/", description: "leaf"),
        Phoneme(symbol: "/k/", description: "key"),
        Phoneme(symbol: "/ch/", description: "change"),
        Phoneme(symbol: "/g/", description: "cake"),
        Phoneme(symbol: "/z/", description: "zebra")
    ]
    
    func selectPhoneme(_ phoneme: Phoneme) {
        print("Selected phoneme: \(phoneme.symbol)")
    }
}
