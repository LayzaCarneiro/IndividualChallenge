//
//  MiniVideoView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 13/12/24.
//

import SwiftUI

struct MiniVideoView: View {
    @State var images: [String] = ["mouth 0", "mouth 1", "mouth 2", "mouth 3"]
    
    @State private var currentIndex = 0
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(images[currentIndex])
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .onReceive(timer) { _ in
                currentIndex = (currentIndex + 1) % images.count
            }
    }
}
