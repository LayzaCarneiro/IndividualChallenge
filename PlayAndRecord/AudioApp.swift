//
//  AudioApp.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 11/12/24.
//

import SwiftUI

struct AudioApp: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationStack {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                
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
            .navigationBarTitle("Voice Recorder")
            .navigationBarItems(trailing: EditButton())
        }
    }
}
