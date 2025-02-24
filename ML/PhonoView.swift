import SwiftUI
import AVFoundation
import CoreML

class PhonoTestViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var isProcessing = false
    @Published var prediction: String?
    @Published var showError = false
    @Published var errorMessage: String?
    @Published var predictedClass: Bool?
    @Published var count: Int = 0 // Make sure count is published

    private var audioEngine: AVAudioEngine?
    private var audioBuffer = AVAudioPCMBuffer() // Acumulador de buffer
    private let model = try! PhonoV2() // Carrega o modelo ML
    private var recordingTimer: Timer?

    private var targetClass: String

    init(targetClass: String) {
        self.targetClass = targetClass
    }

    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            audioEngine = AVAudioEngine()
            guard let audioEngine = audioEngine else { return }

            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            audioBuffer = AVAudioPCMBuffer(pcmFormat: recordingFormat, frameCapacity: 44100 * 2)!

            inputNode.installTap(onBus: 0, bufferSize: 44100, format: recordingFormat) { [weak self] buffer, _ in
                guard let self = self else { return }
                self.audioBuffer.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true

            // Agendar o término após 2 segundos
            recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                self.stopRecording()
            }
        } catch {
            handle(error: error)
        }
    }

    private func stopRecording() {
        recordingTimer?.invalidate()
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        isRecording = false
        processAudio()
    }

    private func processAudio() {
        isProcessing = true

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let audioSamples: MLMultiArray = self.convertBufferToMLMultiArray(self.audioBuffer) // Seu array de dados de áudio
                let phonoModel = try PhonoV2(contentsOf: PhonoV2.urlOfModelInThisBundle)
                let input = PhonoV2Input(audioSamples: audioSamples)

                let output = try phonoModel.prediction(input: input)

                self.printSortedClassProbabilities(output: output)

                // Capturando a classe com maior probabilidade
                DispatchQueue.main.async {
                    if let highestClass = self.getClassWithHighestProbability(output: output) {
                        self.prediction = highestClass
                    }
                    //Before assigning isProcessing = false
                    let isSAboveThreshold = self.isClassAboveThreshold(output: output, targetClass: self.targetClass ?? "")
                    self.predictedClass = isSAboveThreshold //Set predictedClass
                    if isSAboveThreshold {
                        print("A classe \(self.targetClass ?? "") tem probabilidade maior que 75%!!!")
                        self.count += 1 //Increment count
                    } else {
                      print("Did not cross threshold")
                    }
                    self.isProcessing = false

                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        }
    }

    func printSortedClassProbabilities(output: PhonoV2Output) {
        let targetProbabilities = output.targetProbability
        print("Probabilidades das classes (ordenadas):")

        let sortedProbabilities = targetProbabilities.sorted { $0.value > $1.value }

        for (className, probability) in sortedProbabilities {
            print("\(className): \(probability)")
        }
    }

    func isClassAboveThreshold(output: PhonoV2Output, targetClass: String, threshold: Double = 0.02) -> Bool {
        var currentThreshold = threshold // Create a mutable copy

            if (targetClass == "r") {
                currentThreshold = 0.01e-45 // Modify the copy
            } else if (targetClass == "l") {
                currentThreshold = 0.01e-30
            } else if (targetClass == "θ") {
                currentThreshold = 0.01e-30
            } else if (targetClass == "ch") {
                currentThreshold = 0.01e-20
            } else if (targetClass == "g") {
                currentThreshold = 0.01e-30
            } else if (targetClass == "z") {
                currentThreshold = 0.01e-25
            }

            guard let probability = output.targetProbability[targetClass] else {
                return false
            }

            return probability > currentThreshold
    }

    func getClassWithHighestProbability(output: PhonoV2Output) -> String? {
        let targetProbabilities = output.targetProbability
        let sortedProbabilities = targetProbabilities.sorted { $0.value > $1.value }

        return sortedProbabilities.first?.key
    }

    private func convertBufferToMLMultiArray(_ buffer: AVAudioPCMBuffer) -> MLMultiArray {
        let frameCount = buffer.frameLength

        guard let audioSamples = try? MLMultiArray(shape: [NSNumber(value: frameCount)], dataType: .float32) else {
            fatalError("Não foi possível criar MLMultiArray")
        }

        guard let channelData = buffer.floatChannelData?[0] else {
            fatalError("Erro ao acessar os dados do canal de áudio")
        }

        for i in 0..<Int(frameCount) {
            audioSamples[i] = NSNumber(value: channelData[i])
        }

        return audioSamples
    }

    private func handle(error: Error) {
        errorMessage = error.localizedDescription
        showError = true
        isProcessing = false
        isRecording = false
    }
}

extension AVAudioPCMBuffer {
    func append(_ buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData else { return }
        guard let targetChannelData = self.floatChannelData else { return }

        for channel in 0..<Int(buffer.format.channelCount) {
            let source = channelData[channel]
            let target = targetChannelData[channel]

            let targetIndex = Int(self.frameLength)
            let sourceLength = min(Int(buffer.frameLength), Int(self.frameCapacity) - targetIndex)

            if sourceLength > 0 {
                memcpy(target.advanced(by: targetIndex), source, sourceLength * MemoryLayout<Float>.size)
                self.frameLength += AVAudioFrameCount(sourceLength)
            } else {
                print("Buffer cheio, ignorando novos dados")
            }
        }
    }
}
