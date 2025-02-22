//
//  ExerciseCarousel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct ExerciseCarousel: View {
    let phoneme: Phoneme
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(.orange)
                .shadow(radius: 5)
                .overlay(
                    VStack {
                        MiniVideoView(phoneme: phoneme)
                            .padding(.bottom, -20)
                        
                        TipComponent(tip: phoneme.tips[0])
                        TipComponent(tip: phoneme.tips[1])
                        TipComponent(tip: phoneme.tips[2])
                        
                    }
                )
                .padding()
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 1)
                .frame(maxWidth: .infinity, alignment: .center)
                .cornerRadius(10)
        }
    }
}


//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseCarousel(phoneme: Phoneme(symbol: "s", description: "ss"))
//    }
//}
