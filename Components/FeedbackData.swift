//
//  FeedbackData.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 23/02/25.
//

import SwiftUI

struct FeedbackData: View {
    let dataTitle: String
    let data: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("lightYellow"))
            .frame(width: 170, height: 135)
            .overlay(
                VStack(spacing: 3) {
                    Text(dataTitle)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("offWhite"))
                        .frame(width: 155, height: 86)
                        .overlay(
                            Text(data)
                                .font(.system(size: 32, weight: .medium))
                                .foregroundStyle(.black)
                        )
                }
                .padding(.vertical, 10)
            )
    }
}
