//
//  SpeechView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 11/12/24.
//

import SwiftUI

struct SpeechRecognitionView: View {
    @StateObject private var viewModel = SpeechRecognitionViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.recognizedText)
                .padding()
                .border(Color.gray)
            
            Button {
                if viewModel.isRecognizing {
                    viewModel.stopRecognition()
                } else {
                    viewModel.startRecognition()
                }
            } label: {
                Text(viewModel.isRecognizing ? "Stop Recognition" : "Start Recognition")
                    .padding()
                    .background(viewModel.isRecognizing ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            viewModel.requestPermissions()
        }
        .padding()
    }
}
