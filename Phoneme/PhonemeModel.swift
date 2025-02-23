//
//  PhonemeModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct Phoneme: Identifiable {
    let id = UUID()
    let letter: String
    let symbol: String
    let description: String
    let tips: [TipModel]
    let words: [String]
    let soundFile: String
    let icon: String
}
