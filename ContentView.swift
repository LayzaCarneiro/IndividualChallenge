//
//  ContentView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("firstLaunch") var firstLaunch: Bool = true
    
    var body: some View {
        ZStack {
            HomeView()
                .blur(radius: firstLaunch ? 30 : 0)
                .disabled(firstLaunch)
                .animation(.easeOut(duration: 0.8), value: firstLaunch)
                .padding()
            OnBoardingView(firstLaunch: $firstLaunch)
        }
    }
}
