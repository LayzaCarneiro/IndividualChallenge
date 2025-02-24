//
//  TongueTwisterView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI
import AVFoundation

class SpeechSynthesizer: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0

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

    @State var tongueTwister: TongueTwisterModel = TongueTwisterModel(title: "", text: "Loading...", phonemes: [], icon: "mouth.fill")
    @State private var accuracy: Double = 0.0
    @State private var accuracyData: [AccuracyEntry] = []

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        verticalSizeClass == .compact || horizontalSizeClass == .compact
    }

    private var titleFontSize: CGFloat {
        isCompact ? 24 : 32
    }

    private var textFontSize: CGFloat {
        isCompact ? 18 : 24
    }

    private var chartSize: CGFloat {
        isCompact ? 80 : 120
    }

    private var speakerIconSize: CGFloat {
        isCompact ? 20 : 30
    }

    private var textBoxWidth: CGFloat {
        max(isCompact ? UIScreen.main.bounds.width * 0.9 : 773, UIScreen.main.bounds.width * 0.9)
    }

    private var textBoxHeight: CGFloat {
        isCompact ? 150 : 212
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    tongueTwisterText
                    accuracyChart
                    SpeechRecognitionView(viewModel: viewModel)
                    Spacer()
                }
                .padding()
                .padding(.horizontal)

            }
            .navigationTitle("Tongue Twister")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        tongueTwister = tongueTwisterVM.randomTongueTwister()!
                        accuracy = 0.0
                        viewModel.recognizedText = ""
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                    }
                }
            }
            .onAppear {
                if tongueTwister.text == "Loading..." {
                    tongueTwister = tongueTwisterVM.randomTongueTwister()!
                }
            }
            .onChange(of: viewModel.recognizedText) { newValue, _ in
                accuracy = percentage(original: tongueTwister.text, recognized: newValue)
            }
        }
    }

    private var newTongueTwister: some View {
        Button {
            tongueTwister = tongueTwisterVM.randomTongueTwister() ?? TongueTwisterModel(title: "", text: "Loading...", phonemes: [], icon: "mouth.fill")
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

    private var accuracyChart: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(Color.gray.opacity(0.3))

            Circle()
                .trim(from: 0.0, to: CGFloat(accuracy) / 100)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1.0), value: CGFloat(accuracy))

            Text("\(Int(accuracy))")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
        }
        .frame(width: chartSize, height: chartSize)
        .padding()

    }

    private var tongueTwisterText: some View {
        VStack {
            HStack {
                Text(tongueTwister.title)
                    .font(.system(size: titleFontSize, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button {
                    speechSynthesizer.speak(tongueTwister.title)
                    speechSynthesizer.speak(tongueTwister.text)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: speakerIconSize)
                        .padding()
                }
            }

            RoundedRectangle(cornerRadius: 10)
                .fill(.gray)
                .opacity(0.2)
                .frame(width: textBoxWidth, height: textBoxHeight)
                .overlay(
                    Text(tongueTwister.text)
                        .font(.system(size: textFontSize))
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
