//
//  MiniVideoView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 13/12/24.
//

import SwiftUI

struct MiniVideoView: View {
    @State var images: [String] = ["mouth 0", "mouth 1", "mouth 2", "mouth 3"]
    @State private var currentIndex = 0
    @State private var isPlaying = false
    @State private var loopCount = 0
    @State private var maxLoops = 3
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Button {
                if !isPlaying {
                    isPlaying = true
                    loopCount = 0
                } 
            } label: {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
            
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .onReceive(timer) { _ in
                    guard isPlaying else { return }
                    
                    currentIndex = (currentIndex + 1) % images.count
                    
                    if currentIndex == 0 {
                        loopCount += 1
                    }
                    
                    if loopCount >= maxLoops {
                        isPlaying = false
                        loopCount = 0
                    }
                }
        }
    }
}
