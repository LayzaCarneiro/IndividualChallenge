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
    @StateObject private var tongueTwisterVM = TongueTwisterViewModel()

    @State var tongueTwister: TongueTwisterModel = TongueTwisterModel(title: "", text: "Loading...", phonemes: [])
    @State private var accuracy: Double = 0.0
    @State private var accuracyData: [AccuracyEntry] = []

    var body: some View {
        
        ZStack {
            Color("offWhite").edgesIgnoringSafeArea(.all)
            
            VStack {
                newTongueTwister
                tongueTwisterText
                SpeechRecognitionView(viewModel: viewModel)
                listenButton
                Spacer()
            }
            .padding()
            .padding(.horizontal)

        }
        .navigationTitle("Tongue Twister")
        .onAppear {
            tongueTwister = tongueTwisterVM.randomTongueTwister()!
        }
        .onChange(of: viewModel.recognizedText) { newValue, _ in
            accuracy = percentage(original: tongueTwister.text, recognized: newValue)
        }
    }
    
    private var newTongueTwister: some View {
        Button {
            tongueTwister = tongueTwisterVM.randomTongueTwister() ?? TongueTwisterModel(title: "", text: "Loading...", phonemes: [])
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
    }
    
    private var listenButton: some View {
        Button("🔊 Listen") {
            speechSynthesizer.speak(tongueTwister.text)
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    
    private var accuracyChart: some View {
        VStack {
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
    }
    
    private var tongueTwisterText: some View {
        VStack {
            Text(tongueTwister.title)
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .opacity(0.2)
                .frame(width: 773, height: 212)
                .overlay(
                    Text(tongueTwister.text)
                        .font(.system(size: 24))
                        .multilineTextAlignment(.leading)
                        .padding()
                )
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
