//
//  MiniVideoView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 13/12/24.
//

import SwiftUI

struct MiniVideoView: View {
//    @State var images: [String] = ["mouth_ʃ_1", "mouth_ʃ_2", "mouth_ʃ_3", "mouth_ʃ_4", "mouth_ʃ_5", "mouth_ʃ_6", "mouth_ʃ_7"]
    @State private var currentIndex = 0
    @State private var isPlaying = false
    @State private var loopCount = 0
    @State private var maxLoops = 3
    @State var phoneme: Phoneme
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(phoneme.video[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 240)
                .onReceive(timer) { _ in
                    guard isPlaying else { return }
                    
                    currentIndex = (currentIndex + 1) % phoneme.video.count
                    
                    if currentIndex == 0 {
                        loopCount += 1
                    }
                    
                    if loopCount >= maxLoops {
                        isPlaying = false
                        loopCount = 0
                    }
                }
            
            HStack {
                if loopCount == 0 && !isPlaying {
                    Button {
                        if !isPlaying {
                            isPlaying = true
                            loopCount = 0
                        }
                        self.audioPlayer.startPlayback(audio: Bundle.main.url(forResource: phoneme.soundFile, withExtension: "m4a")!)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                    }
                } else {
                    Button {
                        if !isPlaying {
                            isPlaying = true
                            loopCount = 0
                        }
                        self.audioPlayer.stopPlayback()
                    } label: {
                        Image(systemName: "stop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                    }
                    .opacity(0)
                }
            }
        }
    }
}
