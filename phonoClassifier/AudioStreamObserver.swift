//
//  AudioStreamObserver.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 16/12/24.
//

import Foundation
import SoundAnalysis
import Combine

class AudioStreamObserver: NSObject, SNResultsObserving, ObservableObject {
    @Published var currentSound: String = ""
    @Published var topResults: [SNClassification] = []
   
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        guard let classification = result.classifications.first else { return }
        print("Classified Sound: \(classification.identifier)")

        DispatchQueue.main.async {
            self.currentSound = classification.identifier
            self.topResults = Array(result.classifications[0...4])
            print(self.topResults)
        }
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("Sound analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("Sound analysis request completed succesfully!")
    }
}
