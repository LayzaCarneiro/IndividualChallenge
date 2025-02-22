//
//  TongueTwisterListView.swift
//  Phono
//
//  Created by Layza Maria Rodrigues Carneiro on 21/02/25.
//

import SwiftUI

struct TongueTwisterListView: View {
    @StateObject private var tongueTwisterVM = TongueTwisterViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(tongueTwisterVM.tongueTwisters.shuffled().prefix(4)) { tongueTwister in
                    NavigationLink(
                        destination: TongueTwisterView(tongueTwister: tongueTwister),
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 378, height: 121)
                                
                                VStack {
                                    Text(tongueTwister.title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}
