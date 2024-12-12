//
//  Exercise.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI

struct ExerciseView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("x")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                        ProgressBar(color: .cyan)
                    }
                    
                    RepeatWord(audioRecorder: AudioRecorder())
                    
                    Spacer()
                }
                .navigationTitle("Vowel /i/")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
        }
    }
}
