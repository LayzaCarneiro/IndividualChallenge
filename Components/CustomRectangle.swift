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
                    if(UIDevice.current.userInterfaceIdiom == .pad) {
                        Rectangle()
                            .fill(gradient)
                            .frame(width: 232, height: 180)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    } else {
                        Rectangle()
                            .fill(gradient)
                            .frame(width: 100, height: 80)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                    
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
                        
                        HStack {
//                            Image(systemName: icon)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20, height: 20)
//                                .foregroundColor(.white)
                            
                            Text(subtitle)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        )
    }
}
