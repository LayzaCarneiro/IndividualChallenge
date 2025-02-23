//
//  RecordedView.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 22/02/25.
//

import SwiftUI

struct RecordedView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationStack {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                
                recordingButton
            }
            .navigationBarTitle("Recordings")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private var recordingButton: some View {
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
}
