//
//  ExerciseCarousel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct ExerciseCarousel: View {
    let phoneme: Phoneme
    let items = ["Red", "Green"]

    var body: some View {
        TabView {
            ForEach(0..<items.count, id: \.self) { index in
                Rectangle()
                    .fill(getColor(for: items[index]))
                    .shadow(radius: 5)
                    .overlay(
                        VStack {
                            MiniVideoView()
                            
                            Text("Lips")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Text("Pull your lips apart.")
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                    )
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: 600, height: 650)
        .cornerRadius(10)
    }
    
    func getColor(for item: String) -> Color {
        switch item {
        case "Red": return .red
        case "Green": return .green
        default: return .gray
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCarousel(phoneme: Phoneme(symbol: "s", description: "ss"))
    }
}
