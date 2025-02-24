//
//  AudioPlayer.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 11/12/24.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback(audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.setCategory(.playback, mode: .default, options: [])
            try playbackSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set up audio session: \(error)")
            return
        }

        // Verifica se o dispositivo suporta overrideOutputAudioPort
        if playbackSession.category == .playAndRecord {
            do {
                try playbackSession.overrideOutputAudioPort(.speaker)
            } catch {
                print("Failed to route audio to speakers: \(error)")
            }
        }

        // Verifica se o arquivo de áudio existe
        if !FileManager.default.fileExists(atPath: audio.path) {
            print("Erro: O arquivo de áudio não existe no caminho: \(audio.path)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Playback failed: \(error)")
        }
    }

    
//    func startPlayback(audio: URL) {
//        let playbackSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
//        } catch {
//            print("Playing over the device's speakers failed")
//        }
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: audio)
//            audioPlayer.delegate = self
//            audioPlayer.play()
//            isPlaying = true
//        } catch {
//            print("Playback failed.")
//        }
//    }
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}
