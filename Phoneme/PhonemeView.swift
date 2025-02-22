//
//  PhonemeView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct PhonemeListView: View {
    @StateObject private var phonemeVM = PhonemeViewModel()
    @State private var showPhonemeExercise: Bool = false
    @Binding var isExerciseViewPresented: Bool
    @Binding var phonemeExercise: Phoneme

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(phonemeVM.phonemes) { phoneme in
                    Button {
                        phonemeExercise = phoneme
                        showPhonemeExercise.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.blue, Color.cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: 250, height: 120)
                            
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("lightYellow"))
                                        .frame(width: 92, height: 97)
                                    
                                    Image(systemName: "car.fill")
                                        .resizable()
                                        .frame(width: 50, height: 42)
                                        .foregroundStyle(.white)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack {
                                    Text(phoneme.symbol)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    
                                    Text(phoneme.description)
                                        .font(.body)
                                        .foregroundStyle(.white)
                                        .frame(width: 80)
                                }
                                .frame(maxWidth: .infinity)

                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 12, height: 20)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)

                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .sheet(isPresented: $showPhonemeExercise) {
                        PhonemeDetailView(isExerciseViewPresented: $isExerciseViewPresented, phoneme: phonemeExercise)
                    }
                }
            }
            
        }
    }
}
