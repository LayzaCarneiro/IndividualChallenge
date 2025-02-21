//
//  TongueTwisterView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI
import Charts
import AVFoundation

class SpeechSynthesizer: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Altere para outro idioma se quiser
        utterance.rate = 0.5 // Controla a velocidade da fala (0.5 é um bom valor para clareza)
        utterance.pitchMultiplier = 1.0 // Altere para uma voz mais grave/aguda

        synthesizer.speak(utterance)
    }

    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}


struct TongueTwisterView: View {
    @StateObject private var viewModel = SpeechRecognitionViewModel()
    @StateObject private var speechSynthesizer = SpeechSynthesizer()

    @State private var tongueTwister: String = randomTongueTwister() ?? "Loading..."
    @State private var accuracy: Double = 0.0
    @State private var accuracyData: [AccuracyEntry] = []

    var body: some View {
        VStack {
            Button {
                tongueTwister = randomTongueTwister() ?? "Try again!"
                accuracy = 0.0
                viewModel.recognizedText = ""
            } label: {
                Text("New Tongue Twister")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding(.horizontal)
            
            Text(tongueTwister)
                .multilineTextAlignment(.leading)
                .padding()
            
            SpeechRecognitionView(viewModel: viewModel)
            
            Button("🔊 Listen") {
                speechSynthesizer.speak(tongueTwister)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Gauge(value: accuracy, in: 0...100) {
                Text("Accuracy")
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(Gradient(colors: [.red, .green]))
            .frame(width: 150, height: 150)
            
            Text("\(Int(accuracy))%")
                .font(.title)
                .bold()
        }
        .onChange(of: viewModel.recognizedText) { newValue in
            accuracy = percentage(original: tongueTwister, recognized: newValue)
        }
    }
    
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
