import SwiftUI
import AVFoundation
import CoreML

struct PhonoTestView: View {
    @StateObject private var viewModel = PhonoTestViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Teste do Modelo de Áudio")
                .font(.title)
                .bold()

            if viewModel.isRecording {
                Text("Gravando...")
                    .foregroundColor(.red)
            }

            Button(action: {
                viewModel.toggleRecording()
            }) {
                Text(viewModel.isRecording ? "Parar Gravação" : "Iniciar Gravação")
                    .font(.headline)
                    .padding()
                    .background(viewModel.isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isProcessing)

            if let prediction = viewModel.prediction {
                Text("Previsão: \(prediction)")
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Erro"),
                message: Text(viewModel.errorMessage ?? "Erro desconhecido"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

class PhonoTestViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var isProcessing = false
    @Published var prediction: String?
    @Published var showError = false
    @Published var errorMessage: String?

    private var audioRecorder: AVAudioRecorder?
    private var audioEngine: AVAudioEngine?
    private let model = try! Phono() // Carrega o modelo ML

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
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            audioEngine = AVAudioEngine()
            guard let audioEngine = audioEngine else { return }

            let inputNode = audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 15600, format: recordingFormat) { buffer, _ in
                self.processAudio(buffer: buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true
        } catch {
            handle(error: error)
        }
    }

    private func stopRecording() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        isRecording = false
    }

    private func processAudio(buffer: AVAudioPCMBuffer) {
        stopRecording()
        isProcessing = true

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let audioSamples = self.convertBufferToMLMultiArray(buffer)
                let output = try self.model.prediction(audioSamples: audioSamples)
                DispatchQueue.main.async {
                    self.prediction = output.target
                    self.isProcessing = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }
            }
        }
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

struct PhonoTestView_Previews: PreviewProvider {
    static var previews: some View {
        PhonoTestView()
    }
}
