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
            LazyVGrid(columns: columns) {
                ForEach(tongueTwisterVM.tongueTwisters.prefix(4)) { tongueTwister in
                    NavigationLink(
                        destination: TongueTwisterView(tongueTwister: tongueTwister),
                        label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.cyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: 378, height: 121)
                                
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color("lightYellow"))
                                            .frame(width: 92, height: 97)
                                        
                                        Image(systemName: tongueTwister.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 42)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    VStack(alignment: .leading) {
                                        Text(tongueTwister.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .frame(width: 200)
                                            .lineLimit(1)
                                        
                                        Text(tongueTwister.phonemes.joined(separator: ", "))
                                            .font(.body)
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 10)
                                    }
                                    .frame(maxWidth: .infinity)

                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 12, height: 20)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, alignment: .trailing)

                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 1)
                            }
                        }
                    )
                }
            }
        }
    }
}
