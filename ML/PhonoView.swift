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
    
    private var audioEngine: AVAudioEngine?
    private var audioBuffer = AVAudioPCMBuffer() // Acumulador de buffer
    private let model = try! PhonoV2() // Carrega o modelo ML
    private var recordingTimer: Timer?
    
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
            //            recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            //                self.stopRecording()
            //            }
        } catch {
            handle(error: error)
        }
    }
    
    private func stopRecording() {
        recordingTimer?.invalidate()
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        isRecording = false
        
        // Processar o áudio acumulado
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
                    self.isProcessing = false
                    
                }
            } catch {
                DispatchQueue.main.async {
                    self.handle(error: error)
                }}
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

struct PhonoTestView_Previews: PreviewProvider {
    static var previews: some View {
        PhonoTestView()
    }
}
