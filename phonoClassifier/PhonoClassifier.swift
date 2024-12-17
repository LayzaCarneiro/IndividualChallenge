//
//  PhonoClassifier.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 16/12/24.
//

import SwiftUI

struct PhonoClassifier: View {
    @ObservedObject var observer: AudioStreamObserver
    @State var text: String = ""
    private var streamManager: AudioStreamManager
    
    init() {
        observer = AudioStreamObserver()
        streamManager = AudioStreamManager()
        streamManager.resultObservation(with: observer)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(observer.currentSound)
                    .padding()
                ChartView(observer: observer)
        
            Spacer()
            ListenButton(streamManager: streamManager)
               
        }
    }
}

struct PhonoClassifier_Previews: PreviewProvider {
    static var previews: some View {
        PhonoClassifier()
    }
}
