//
//  AudioPlayerViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 10/12/24.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying = false
    
//    init() {
//        if let sound = Bundle.main.path(forResource: "PocketCyclopsLvl1", ofType: "mp3") {
//            do {
//                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
//            } catch {
//                print("AVAudioPlayer could not be instantiated.")
//            }
//        } else {
//            print("Audio file could not be found.")
//        }
//    }
    
    func loadAudio(from url: URL) {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
        }
    }
    
    func playOrPause() {
        guard let player = audioPlayer else { return }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}
