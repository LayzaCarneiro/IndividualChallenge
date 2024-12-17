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
