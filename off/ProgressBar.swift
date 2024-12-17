//
//  ProgressBar.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 09/12/24.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Double = 0
    var total: Double = 100
    var color: Color
    
    var body: some View {
        ProgressView(value: progress, total: total)
            .progressViewStyle(BarProgressStyle(color: color))
            .padding()
            .animation(.easeInOut(duration: 0.5), value: progress)
    }
}

struct BarProgressStyle: ProgressViewStyle {
    var color: Color = .green
    
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color(.white))
                .frame(height: 17)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 4)
                        .frame(height: 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(color)
                        .frame(width: 127 * progress)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 4)
                                .frame(width: 127 * progress)
                        )
                        .overlay {
                            if let currentValueLabel = configuration.currentValueLabel {
                                currentValueLabel
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                }
        }
    }
}
