//
//  RandomTextView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct RandomTextView: View {
    @ObservedObject private var audioRecorder = AudioRecorder()
    let randomText = randomStory()

    var body: some View {
        NavigationStack {
            VStack {
                Text(randomText?.title ?? "")
                Text(randomText?.text ?? "")
                
                Spacer()
                
                if audioRecorder.recording == false {
                    Button { self.audioRecorder.startRecording() } label: {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button { self.audioRecorder.stopRecording() } label: {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitle("Recordings")
        }
    }
}
