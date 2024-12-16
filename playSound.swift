import SwiftUI
import AVFoundation

struct playSound: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var playing = false
    @State private var fileName: String = ":s:"
    @State private var extensionType: String = "m4a"

    var body: some View {
        Button {
            if playing {
                stopAudio()
            } else {
                playAudio(fileName, extensionType)
            }
            
            playing.toggle()
        } label: {
            HStack {
                Image(systemName: playing ? "stop.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                Text(playing ? "Stop sound" : "Play sound")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
        }
    }

    func playAudio(_ fileName: String, _ extensionType: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            print("Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopAudio() {
        audioPlayer?.stop()
    }
}

struct playSoundPreviews: PreviewProvider {
    static var previews: some View {
        playSound()
    }
}
