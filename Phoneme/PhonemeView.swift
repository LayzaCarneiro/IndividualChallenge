//
//  PhonemeView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct PhonemeListView: View {
    @StateObject private var phonemeVM = PhonemeViewModel()
    @State private var isPresented: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns, spacing: 20) {
                
                ForEach(phonemeVM.phonemes) { phoneme in
                    NavigationLink(
                        destination: PhonemeDetailView(phoneme: phoneme),
                        label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 250, height: 100)
                                    .foregroundStyle(.blue)
                                    .cornerRadius(8)
                                VStack {
                                    Text(phoneme.symbol)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text(phoneme.description)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}


struct PhonemeDetailView: View {
    @State var isPresented: Bool = false
    let phoneme: Phoneme

    var body: some View {
        VStack(spacing: 16) {
            Text(phoneme.symbol)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Example word: \(phoneme.description)")
                .font(.title3)
                .padding(.bottom, 16)

            Spacer()
            
            Button {
                isPresented = true
            } label: {
                Text("Start Exercises")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isPresented) {
                ExerciseView(viewModel: ExerciseViewModel())
            }
        }
        .padding()
        .navigationTitle(phoneme.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}
