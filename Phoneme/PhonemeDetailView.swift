//
//  PhonemeDetailView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 16/12/24.
//

import SwiftUI

struct PhonemeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isExerciseViewPresented: Bool
    
    @State var isPresented: Bool = false
    let phoneme: Phoneme
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color("offWhite").ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        phonemeIcon
                        phonemeTutorial
                        phonemeTips
                        startExerciseButton
                    }
                }
            }
            .navigationTitle("Phoneme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
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
    
    private var phonemeTutorial: some View {
        VStack(alignment: .leading) {
            Text("How to make the sound")
                .font(.system(size: 24, weight: .bold))
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("offWhite"))
                .stroke(.black)
                .frame(width: 540, height: 220)
                .overlay(
                    MiniVideoView(phoneme: phoneme)
                        .padding(.top, 30)
                )
        }
    }
    
    private var phonemeTips: some View {
        VStack(alignment: .leading) {
            Text("Tips")
                .font(.system(size: 24, weight: .bold))
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("offWhite"))
                .stroke(.black)
                .frame(width: 540, height: 220)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(phoneme.tips[0].title)
                            Text(phoneme.tips[0].description)
                        }
                        HStack(alignment: .top) {
                            Text(phoneme.tips[1].title)
                            Text(phoneme.tips[1].description)
                        }
                        HStack(alignment: .top) {
                            Text(phoneme.tips[2].title)
                            Text(phoneme.tips[2].description)
                        }
                    }
                    .padding()
                )
        }
    }
    
    private var startExerciseButton: some View {
        Button {
            self.isExerciseViewPresented = true
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .frame(width: 540, height: 72)
                .overlay(
                    Text("Start Exercise")
                        .font(.system(size: 26, weight: .bold))
//                        .padding(.vertical, 15)
//                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44)
//                        .controlSize(.large)
                        .foregroundStyle(.white)
                )
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            dismiss()
        }
    }
}
