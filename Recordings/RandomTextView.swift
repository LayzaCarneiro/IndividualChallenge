//
//  RandomTextView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct RandomTextView: View {
    @ObservedObject private var audioRecorder = AudioRecorder()
    @State var randomText = randomStory()
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("offWhite"))
                    .stroke(.black)
                    .frame(width: 770, height: 730)
                    .overlay(text)
                
                Spacer()
                recordingButton
            }
        }
        .navigationBarTitle("Recordings")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    randomText = randomStory()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.title2)
                }
            }
        }
    }
    
    private var text: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text(randomText?.title ?? "")
                    .font(.system(size: 24, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(randomText?.text ?? "")
                    .font(.system(size: 24))
                
                Spacer()
            }
            .padding()
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
