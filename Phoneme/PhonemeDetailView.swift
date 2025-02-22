//
//  PhonemeDetailView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 16/12/24.
//

import SwiftUI

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

            VStack {
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
                    ExerciseView(viewModel: ExerciseViewModel(), phoneme: phoneme)
                }
            }
            .padding()
        }
        .navigationTitle(phoneme.symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}
