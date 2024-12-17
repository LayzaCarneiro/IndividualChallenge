//
//  RTSoundClassifier.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 16/12/24.
//

import Foundation
import CoreML

class RTSoundClassifier {
    private var model: PhonoClassifier?
    
    init() {
        model = try? PhonoClassifier()
    }
}
