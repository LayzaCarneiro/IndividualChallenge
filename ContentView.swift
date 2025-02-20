//
//  ContentView.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") var firstLaunch: Bool = true
    
    var body: some View {
        ZStack {
            HomeView()
                .blur(radius: firstLaunch ? 30 : 0)
                .disabled(firstLaunch)
            OnBoardingView(firstLaunch: $firstLaunch)
        }
    }
}
