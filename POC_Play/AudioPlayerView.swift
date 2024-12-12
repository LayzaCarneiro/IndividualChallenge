//
//  AudioPlayerView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 10/12/24.
//

import SwiftUI

struct AudioPlayerView: View {
  @StateObject var audioPlayerViewModel = AudioPlayerViewModel()

  var body: some View {
    VStack {
      Button(action: {
        audioPlayerViewModel.playOrPause()
      }) {
        Image(systemName: audioPlayerViewModel.isPlaying ? "pause.circle" : "play.circle")
          .resizable()
          .frame(width: 64, height: 64)
      }
    }
  }
}
