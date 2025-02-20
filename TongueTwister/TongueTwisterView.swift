//
//  TongueTwisterView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI
import Charts

struct TongueTwisterView: View {
    @StateObject private var viewModel = SpeechRecognitionViewModel()
    let tongueTwister: String = randomTongueTwister() ?? "Loading..."
    
    @State private var accuracy: Double = 0.0
    @State private var accuracyData: [AccuracyEntry] = []

    var body: some View {
        VStack {
            Text(tongueTwister)
                .multilineTextAlignment(.leading)
                .padding()
            
            SpeechRecognitionView(viewModel: viewModel)
            
        }
    }
    
    // Função para pré-processar o texto (remover pontuações e normalizar)
    func preprocess(_ text: String) -> [String] {
        let cleanText = text.lowercased()
            .components(separatedBy: CharacterSet.punctuationCharacters.union(.whitespacesAndNewlines))
            .filter { !$0.isEmpty }
        return cleanText
    }

    func accuracyPercentage(original: String, recognized: String) -> Double {
        let originalWords = preprocess(original)
        let recognizedWords = preprocess(recognized)
        
        let correctWords = zip(originalWords, recognizedWords).filter { $0 == $1 }.count
        let totalWords = max(originalWords.count, recognizedWords.count)
        
        return totalWords > 0 ? (Double(correctWords) / Double(totalWords)) * 100.0 : 0.0
    }
    
    func percentage(original: String, recognized: String) -> Double {
        let originalTongueTwister = original
        let recognizedSpeech = recognized
        
        let accuracy = accuracyPercentage(original: originalTongueTwister, recognized: recognizedSpeech)
        print("Accuracy: \(accuracy)%")
        
        return accuracy
    }

}

