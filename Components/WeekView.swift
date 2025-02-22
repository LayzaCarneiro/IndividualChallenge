//
//  WeekView.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 21/02/25.
//

import SwiftUI

struct WeekView: View {
    let gradient = LinearGradient(
        colors: [Color.red, Color.orange],
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        ZStack {
            if(UIDevice.current.userInterfaceIdiom == .pad) {
                Rectangle()
                    .fill(gradient)
                    .frame(width: 300, height: 180)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(gradient)
                    .frame(width: 100, height: 80)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        }
    }
}
