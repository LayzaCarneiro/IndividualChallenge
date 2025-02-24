//
//  CustomButton.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct CustomButton: View {    
    let text: String
    let gradient: LinearGradient
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(gradient)
                    .frame(width: 400, height: 50)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Text(text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
    }
}
