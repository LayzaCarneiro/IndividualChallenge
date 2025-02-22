//
//  OnBoardingView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var firstLaunch: Bool
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "speaker.wave.3.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
            }
            
            Text("Welcome to Phono")
                .fontWeight(.bold)
                .font(.title)
            
            TextField("Name", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                firstLaunch = false
            } label: {
                CustomButton(text: "Next", gradient: LinearGradient(
                    colors: [Color.red, Color.orange],
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .padding()
        .padding(30)
        .background(.ultraThinMaterial)
        .font(.system(.body, design: .rounded))
        .cornerRadius(15)
        .opacity(firstLaunch ? 1 : 0)
        .frame(maxWidth: 500)
    }
    
}

