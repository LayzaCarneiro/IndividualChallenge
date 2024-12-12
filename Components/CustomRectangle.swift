//
//  CustomRectangle.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct CustomRectangle: View {
    @State var text = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 387, height: 180)
                .cornerRadius(10)
                .foregroundStyle(.blue)
            
            Text(text)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    CustomRectangle()
}
