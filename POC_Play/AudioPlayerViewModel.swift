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
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print("Failed to set up AVAudioSession: \(error.localizedDescription)")
//        }
//        
//        if let sound = Bundle.main.path(forResource: "PocketCyclopsLvl1", ofType: "mp3") {
//            do {
//                self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
//                self.audioPlayer?.prepareToPlay()
//            } catch {
//                print("AVAudioPlayer could not be instantiated.")
//            }
//        } else {
//            print("Audio file could not be found.")
//        }
//    }
    
    init() {
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up AVAudioSession: \(error.localizedDescription)")
        }
    }
    
    func loadAudio(fromPath filePath: String) {
        let fileURL = URL(fileURLWithPath: filePath)
        print("Loading audio from path: \(filePath)")

        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            self.audioPlayer?.prepareToPlay()
            print("Audio loaded successfully from \(filePath)")
        } catch {
            print("Error loading audio from \(filePath): \(error.localizedDescription)")
        }
    }
    
    func playOrPause() {
        guard let player = audioPlayer else {
            print("Audio player is not initialized.")
            return
        }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}
