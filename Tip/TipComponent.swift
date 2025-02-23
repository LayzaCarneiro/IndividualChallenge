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
        VStack(alignment: .leading) {
            Text("\(tip.title)")
                .font(.body)
                .fontWeight(.bold)
            
            Text(tip.description)
                .font(.body)
                .lineLimit(3)
                .truncationMode(.tail)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//#Preview {
//    TipComponent(tip: TipModel(title: "Lips", description: "Pull your lips apart."))
//}
