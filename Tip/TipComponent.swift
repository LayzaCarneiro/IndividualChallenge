//
//  TipComponent.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 13/12/24.
//

import SwiftUI

struct TipComponent: View {
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(8)
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
            
            HStack(spacing: 25) {
                Text("\(title)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                
                Text(description)
                    .font(.title3)
                    .foregroundStyle(.blue)
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
        }
    }
}

//#Preview {
////    TipComponent(tip: TipModel(title: "Lips", description: "Pull your lips apart."))
//}
