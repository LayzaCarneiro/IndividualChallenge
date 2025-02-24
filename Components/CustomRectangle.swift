//
//  CustomRectangle.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//

import SwiftUI

struct CustomRectangle: View {
    let gradient: LinearGradient
    let title: String
    let imageName: String
    let icon: String
    let subtitle: String
    @State var view: AnyView
    
    var body: some View {
        NavigationLink(
            destination: view,
            label: {
                ZStack {
                    Rectangle()
                        .fill(gradient)
                    //                                .frame(width: 1, height: geometry.size.height * 18)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageName == "waveSound" ? 100 : 70, height: imageName == "waveSound" ? 60 : 60)
                            .foregroundStyle(.white)
                        
                        Text(subtitle)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                }
            }
        )
    }
}
