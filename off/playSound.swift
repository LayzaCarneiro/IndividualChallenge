//import SwiftUI
//import AVFoundation
//
//struct playSound: View {
//    @State private var audioPlayer: AVAudioPlayer?
//    @State private var playing = false
//    @State var fileName: String
//    @State private var extensionType: String = "m4a"
//
//    var body: some View {
//        Button {
//            if playing {
//                stopAudio()
//            } else {
//                playAudio(fileName, extensionType)
//            }
//            
//            playing.toggle()
//        } label: {
//            HStack {
//                Image(systemName: playing ? "stop.circle.fill" : "play.circle.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.blue)
//                Text(playing ? "Stop sound" : "Play sound")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//            }
//            .padding()
//        }
//    }
//
//    func playAudio(_ fileName: String, _ extensionType: String) {
//        guard let url = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
//            print("Audio file not found")
//            return
//        }
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.play()
//        } catch {
//            print("Error playing audio: \(error.localizedDescription)")
//        }
//    }
//    
//    func stopAudio() {
//        audioPlayer?.stop()
//    }
//}
//

import SwiftUI
import AVFoundation

struct PlaySoundButton: View {
    @State private var audioPlayer: AVAudioPlayer?
//    @State private var isPlaying = false
    var fileName: String
    var fileExtension: String = "m4a"
    
    @State private var audioEngine: AVAudioEngine?
    @State private var playerNode: AVAudioPlayerNode?
    @State private var eqNode: AVAudioUnitEQ?
    @State private var isPlaying = false

    var body: some View {
        Button {
            if !isPlaying {
                playSound()
            }
        } label: {
            HStack {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Text(isPlaying ? "Playing..." : "Play Sound")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
        }
    }
    
//    private func playSound() {
//        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
//            print("Audio file not found")
//            return
//        }
//        
//        do {
//            let file = try AVAudioFile(forReading: url)
//            audioEngine = AVAudioEngine()
//            playerNode = AVAudioPlayerNode()
//            eqNode = AVAudioUnitEQ(numberOfBands: 1)
//            
//            guard let audioEngine = audioEngine, let playerNode = playerNode, let eqNode = eqNode else { return }
//            
//            // Configurar equalizador para aumentar o volume
//            let band = eqNode.bands[0]
//            band.filterType = .parametric
//            band.frequency = 1000  // Foca em frequências de voz
//            band.gain = 10.0        // Aumenta o volume em 10dB
//            band.bypass = false
//            
//            // Configurar o pipeline de áudio
//            audioEngine.attach(playerNode)
//            audioEngine.attach(eqNode)
//            audioEngine.connect(playerNode, to: eqNode, format: file.processingFormat)
//            audioEngine.connect(eqNode, to: audioEngine.mainMixerNode, format: file.processingFormat)
//            
//            // Iniciar reprodução
//            playerNode.scheduleFile(file, at: nil, completionHandler: nil)
//            try audioEngine.start()
//            playerNode.play()
//            
//            isPlaying = true
//        } catch {
//            print("Error playing audio: \(error.localizedDescription)")
//        }
//    }

    // Função para iniciar o som
    private func playSound() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.volume = 1.0

            audioPlayer?.delegate = AVAudioPlayerDelegateHandler {
                isPlaying = false 
            }
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

// Handler para o AVAudioPlayerDelegate
class AVAudioPlayerDelegateHandler: NSObject, AVAudioPlayerDelegate {
    private let onFinish: () -> Void

    init(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            onFinish()
        }
    }
}
