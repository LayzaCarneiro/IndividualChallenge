//
//  ExerciseCarousel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct ExerciseCarousel: View {
    let phoneme: Phoneme
    let items = ["Red"]

    var body: some View {
        TabView {
            ForEach(0..<items.count, id: \.self) { index in
                Rectangle()
                    .fill(getColor(for: items[index]))
                    .shadow(radius: 5)
                    .overlay(
                        VStack {
                            MiniVideoView()
                            
                            TipComponent(title: "1. Lips", description: "Pull your lips apart.")
                            TipComponent(title: "2. Tongue", description: "Raise your tongue tip up.")
                            TipComponent(title: "3. Respiration", description: "Air slides down the tongue.")

                        }
                    )
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: 600, height: 750)
        .cornerRadius(10)
    }
    
    func getColor(for item: String) -> Color {
        switch item {
        case "Red": return .orange
        default: return .gray
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCarousel(phoneme: Phoneme(symbol: "s", description: "ss"))
    }
}
