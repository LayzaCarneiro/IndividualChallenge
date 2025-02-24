//
//  Exercise.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI
import Speech

struct ExerciseView: View {
    @StateObject var viewModel = ExerciseViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool

    @State private var isShowConfirmEndExercise = false
    @State private var isShowFeedback = false
    @State var isShowConfirmSkipStep = false
    @State private var isExpanded = false

    let phoneme: Phoneme

    @ObservedObject var viewModelSpeech = SpeechRecognitionViewModel()
    @State var wordsToRecognize: [String] = []
    @State var wordsRecognized: [String] = []
    @State private var allWordsRecognized: Bool = false

    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    private var isCompact: Bool {
        verticalSizeClass == .compact || horizontalSizeClass == .compact
    }

    private var titleFontSize: CGFloat {
        isCompact ? 24 : 32
    }

    private var subTitleFontSize: CGFloat {
        isCompact ? 18 : 24
    }

    private var videoWidth: CGFloat {
        isCompact ? UIScreen.main.bounds.width * 0.8 : 540
    }

    private var videoHeight: CGFloat {
        isCompact ? 150 : 260
    }

    private var buttonFontSize: CGFloat {
        isCompact ? 14 : 16
    }

    var body: some View {

        VStack(spacing: 20) {
            progressView

            if viewModel.currentStepIndex == 0 {
                exerciseViewOne
            } else {
                exerciseViewTwo
            }

            Spacer()
        }

    }

    private var exerciseViewOne: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Step 1: Repeat 3 times the sound \(phoneme.symbol)")
                    .font(.system(size: titleFontSize, weight: .bold))
                    .foregroundColor(.blue)

                phonemeTutorial
                seeTips

                RepeatSound(audioRecorder: AudioRecorder(), ExerciseVM: viewModel, phoneme: phoneme)
            }
        }
    }

    private var exerciseViewTwo: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Step 2: Repeat the following words")
                    .font(.system(size: titleFontSize, weight: .bold))
                    .foregroundColor(.blue)

                ForEach(wordsToRecognize, id: \.self) { word in
                    Text(word)
                        .font(.title)
                        .foregroundColor(wordsRecognized.contains(word.lowercased()) ? .green : .black)
                }

                Text(viewModelSpeech.recognizedText)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)

                Spacer()

                Button {
                    if viewModelSpeech.isRecognizing {
                        viewModelSpeech.stopRecognition()
                    } else {
                        viewModelSpeech.startRecognition()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill((viewModelSpeech.isRecognizing && !allWordsRecognized) ? Color.red.opacity(0.3) : Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Circle()
                                    .stroke((viewModelSpeech.isRecognizing && !allWordsRecognized) ? Color.red : Color.blue, lineWidth: 4)
                                    .scaleEffect((viewModelSpeech.isRecognizing && !allWordsRecognized) ? 1.3 : 1.0)
                                    .opacity((viewModelSpeech.isRecognizing && !allWordsRecognized) ? 0.6 : 0.8)
                            )

                        Image(systemName: (viewModelSpeech.isRecognizing && !allWordsRecognized) ? "stop.fill" : "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Circle().fill((viewModelSpeech.isRecognizing && !allWordsRecognized) ? Color("darkOrange") : Color.blue).frame(width: 80, height: 80))
                            .shadow(color: (viewModelSpeech.isRecognizing && !allWordsRecognized) ? Color("darkOrange").opacity(0.7) : .blue.opacity(0.5), radius: 8)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(allWordsRecognized)

            }
            .onAppear {
                viewModelSpeech.requestPermissions()
                wordsToRecognize = phoneme.words
                startCheckTimer() // Start timer on appear
            }
            .onDisappear {
                stopCheckTimer() // Stop timer on disappear
            }
            .onChange(of: viewModelSpeech.recognizedText) { newText, _ in
                resetCheckTimer() // Reset timer on text change
            }
            .onChange(of: wordsRecognized) { _, _ in
                allWordsRecognized = wordsToRecognize.allSatisfy { word in
                    wordsRecognized.contains(word.lowercased())
                }

                if allWordsRecognized {
                    print("All words recognized!")
                    stopCheckTimer()
                    viewModelSpeech.stopRecognition()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isShowFeedback.toggle()
                    }
                }
            }
            .padding(.top, 20)
        }
    }

    private var progressView: some View {
        HStack {
            Button {
                isShowConfirmEndExercise.toggle()
            } label: {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text("X")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                    )
            }
            .alert("End practice", isPresented: $isShowConfirmEndExercise) {
                Button("Cancel", role: .cancel) {
                }
                Button("End", role: .destructive) {
                    isPresented.toggle()
                }
            } message: {
                Text("Are you sure you want to end the practice session?")
            }

            ProgressView(value: viewModel.progress)
                .progressViewStyle(ThickProgressViewStyle())
                .animation(.easeInOut(duration: 0.5), value: viewModel.progress)
                .padding()

            nextStepButton
        }
    }

    private var phonemeTutorial: some View {
        VStack(alignment: .leading) {
            Text("How to make the sound")
                .font(.system(size: subTitleFontSize, weight: .bold))

            RoundedRectangle(cornerRadius: 10)
                .fill(Color("offWhite"))
                .stroke(.black)
                .frame(width: videoWidth, height: videoHeight)
                .overlay(
                    MiniVideoView(phoneme: phoneme)
                )
        }
    }

    private var seeTips: some View {
        VStack {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("See tips")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }


            if isExpanded {
                ScrollView {
                    VStack(alignment: .leading) {
                        TipComponent(tip: phoneme.tips[0])
                        TipComponent(tip: phoneme.tips[1])
                        TipComponent(tip: phoneme.tips[2])

                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .padding()

    }

    private var nextStepButton: some View {
        Button {
            isShowConfirmSkipStep.toggle()
        } label: {
            Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip" : "Finish")
                .font(.system(size: buttonFontSize, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .background(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? Color.blue : Color.green)
                .clipShape(Capsule())
        }

        .buttonStyle(PlainButtonStyle())
        .animation(.easeInOut(duration: 0.2), value: viewModel.currentStepIndex)
        .alert(isPresented: $isShowConfirmSkipStep) {
            Alert(
                title: Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip Step" : "Finish Exercise"),
                message: Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ?
                              "Are you sure you want to skip this step?" :
                                "Are you sure you want to finish the exercise?"),
                primaryButton: .destructive(Text(viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 ? "Skip" : "Finish")) {
                    if viewModel.currentStepIndex < viewModel.currentExercise.steps.count - 1 {
                        viewModel.goToNextStep()
                    
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isShowFeedback.toggle()
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $isShowFeedback) {
            FeedbackView(isExerciseViewPresented: $isPresented, phoneme: phoneme)
        }

    }

    // Timer-related properties
    @State private var checkTimer: Timer? = nil
    let checkInterval: TimeInterval = 0.5 // Adjust this interval as needed

    func startCheckTimer() {
        checkTimer = Timer.scheduledTimer(withTimeInterval: checkInterval, repeats: true) { _ in
            checkLastWord()
        }
    }

    func stopCheckTimer() {
        checkTimer?.invalidate()
        checkTimer = nil
    }

    func resetCheckTimer() {
        stopCheckTimer()
        startCheckTimer()
    }

    func checkLastWord() {
        guard !allWordsRecognized else { return } // Exit if all words already recognized

        let newText = viewModelSpeech.recognizedText
        let lastWord = newText.components(separatedBy: .whitespaces).last ?? ""

        if !lastWord.isEmpty && !wordsRecognized.contains(lastWord.lowercased()) {
            wordsRecognized.append(lastWord.lowercased())
            print("Appended word: \(lastWord)") // For debugging
        }
    }
}

struct ThickProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .scaleEffect(x: 1, y: 4, anchor: .center)
    }
}
