//
//  FeedbackView.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 23/02/25.
//

import SwiftUI

struct FeedbackView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isExerciseViewPresented: Bool
    let phoneme: Phoneme
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color("offWhite").ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        phonemeIcon
                        
                        Text("Congratulations 🎉")
                        
                        Spacer()
                        
                        HStack {
                            FeedbackData(dataTitle: "Time", data: "3:04")
                            FeedbackData(dataTitle: "Time", data: "3:04")
                        }
                        
                        doneExerciseButton
                    }
                }
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private var phonemeIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [Color.blue, Color.cyan],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 540, height: 100)
                .padding(.horizontal)
            
            VStack {
                Text(phoneme.symbol)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(phoneme.description)
                    .font(.body)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .padding(.vertical)
        }
        
    }
    
    private var doneExerciseButton: some View {
        Button {
            self.isExerciseViewPresented = false
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .frame(width: 540, height: 72)
                .overlay(
                    Text("Done")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                )
        }
    }
}
