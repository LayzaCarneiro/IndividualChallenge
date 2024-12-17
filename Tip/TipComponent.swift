//
//  TipComponent.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 13/12/24.
//

import SwiftUI

struct TipComponent: View {
    @State var tip: TipModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(8)
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
            
            HStack(spacing: 25) {
                Text("\(tip.title)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                
                Text(tip.description)
                    .font(.title3)
                    .foregroundStyle(.blue)
                    .padding(.top, 5)
                    .truncationMode(.tail) // Trunca o texto se exceder o limite
                    .frame(width: 330)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
        }
    }
}

//#Preview {
//    TipComponent(tip: TipModel(title: "Lips", description: "Pull your lips apart."))
//}
