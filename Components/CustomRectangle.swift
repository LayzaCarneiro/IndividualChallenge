//
//  CustomRectangle.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct CustomRectangle: View {
    let text: String
    let gradient: LinearGradient
    let info: String
    @State var icon: String = ""
    @State var subtitle: String = ""
    @State var view: AnyView
    
    var body: some View {
        NavigationLink(
            destination: view,
            label: {
                ZStack {
                    Rectangle()
                        .fill(gradient)
                        .frame(width: 387, height: 180)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 8) {
                        
                        HStack(spacing: 10) {
                            Image(systemName: icon)
                                .font(.system(size: 33, weight: .bold))
                                .foregroundStyle(.white)
                                .opacity(0.9)
                            
                            Text(info)
                                .font(.system(size: 40, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing, 25)
                        
                        Text(text)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        if subtitle != "" {
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding()
                }
            }
        )
    }
}
