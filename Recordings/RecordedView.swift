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
        Group {
            if audioRecorder.recording == false {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.audioRecorder.startRecording()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 4)
                                    .scaleEffect(1.0)
                                    .opacity(0.8)
                            )
                        
                        Image(systemName: "mic.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue).frame(width: 80, height: 80))
                            .shadow(color: .blue.opacity(0.5), radius: 8)
                    }
                }
            } else {
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.audioRecorder.stopRecording()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Circle()
                                    .stroke(Color.red, lineWidth: 4)
                                    .scaleEffect(1.3)
                                    .opacity(0.6)
                            )
                        
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color("darkOrange")).frame(width: 80, height: 80))
                            .shadow(color: Color("darkOrange").opacity(0.7), radius: 8)
                    }
                }
            }
        }
    }
    
}
