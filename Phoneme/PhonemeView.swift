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
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 250, height: 120)
                                
                                VStack(spacing: 8) {
                                    Text(phoneme.symbol)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text(phoneme.description)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.white.opacity(0.9))
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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.orange.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                Text(phoneme.symbol)
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding()

                Text("Example word: \(phoneme.description)")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .padding(.bottom, 16)

                ExerciseCarousel(phoneme: phoneme)
                    .padding(.top, 15)
                
                Spacer()

                Button {
                    isPresented = true
                } label: {
                    Text("Start Exercises")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding()
                .fullScreenCover(isPresented: $isPresented) {
                    ExerciseView(viewModel: ExerciseViewModel())
                }
            }
            .padding()
        }
        .navigationTitle(phoneme.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//struct PhonemeDetailView: View {
//    @State var isPresented: Bool = false
//    let phoneme: Phoneme
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text(phoneme.symbol)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//
//            Text("Example word: \(phoneme.description)")
//                .font(.title3)
//                .padding(.bottom, 16)
//            
//            ExerciseCarousel(phoneme: phoneme)
//                .padding(.top, 50)
//            
//            Spacer()
//            
//            Button {
//                isPresented = true
//            } label: {
//                Text("Start Exercises")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .fullScreenCover(isPresented: $isPresented) {
//                ExerciseView(viewModel: ExerciseViewModel())
//            }
//        }
//        .padding()
//        .navigationTitle(phoneme.symbol)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
