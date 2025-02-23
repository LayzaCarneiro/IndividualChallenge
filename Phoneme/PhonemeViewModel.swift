//
//  PhonemeViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 12/12/24.
//
import SwiftUI

class PhonemeViewModel: ObservableObject {
    @Published var phonemes: [Phoneme] = [
        Phoneme(letter: "ʃ", symbol: "/ʃ/", description: "ship", tips: [
            TipModel(title: "1. Lips", description: "Round your lips slightly."),
            TipModel(title: "2. Tongue", description: "Raise the middle of your tongue close to the roof of the mouth."),
            TipModel(title: "3. Respiration", description: "Blow air gently to produce a hissing sound.")
        ], words: ["shop", "dash", "issue", "sugar", "motion", "pushed"], soundFile: "ʃ", icon: "sailboat.fill", video: ["mouth_ʃ_1", "mouth_ʃ_2", "mouth_ʃ_3", "mouth_ʃ_4", "mouth_ʃ_5", "mouth_ʃ_6", "mouth_ʃ_7"]),
        
        Phoneme(letter: "s", symbol: "/s/", description: "sun", tips: [
            TipModel(title: "1. Lips", description: "Keep your lips spread."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue close to the upper front teeth."),
            TipModel(title: "3. Respiration", description: "Blow air in a controlled stream to create a sharp hissing sound.")
        ], words: ["sample", "stocks", "past", "race", "slip", "strong"], soundFile: "s", icon: "sun.max.fill", video: ["mouth_s_1", "mouth_s_2", "mouth_s_3", "mouth_s_4", "mouth_s_5", "mouth_s_6", "mouth_s_7"]),
        
        Phoneme(letter: "θ", symbol: "/θ/", description: "think", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue lightly between your teeth."),
            TipModel(title: "3. Respiration", description: "Blow air softly through the gap between your tongue and teeth.")
        ], words: ["thanks", "thought", "bath", "fifth", "nothing"], soundFile: "θ", icon: "cloud.fill", video: ["mouth_θ_1", "mouth_θ_2", "mouth_θ_3", "mouth_θ_4", "mouth_θ_5"]),
        
        Phoneme(letter: "ð", symbol: "/ð/", description: "this", tips: [
            TipModel(title: "1. Lips", description: "Keep your lips neutral."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue gently between your teeth."),
            TipModel(title: "3. Vibration", description: "Feel a slight vibration in your throat as you blow air.")
        ], words: ["the", "either", "breathe", "therefore"], soundFile: "ð", icon: "hand.point.up.left.fill", video: ["mouth_ð_1", "mouth_ð_2", "mouth_ð_3", "mouth_ð_4", "mouth_ð_5"]),
        
        Phoneme(letter: "r", symbol: "/r/", description: "rabbit", tips: [
            TipModel(title: "1. Lips", description: "Slightly round your lips."),
            TipModel(title: "2. Tongue", description: "Curl the tip of your tongue upward, without touching the roof of the mouth."),
            TipModel(title: "3. Vibration", description: "Let air flow freely without any friction.")
        ], words: ["store", "third", "track", "start", "ring", "rocket"], soundFile: "r", icon: "hare.fill", video: ["mouth_r_1", "mouth_r_2", "mouth_r_3", "mouth_r_4", "mouth_r_5", "mouth_r_6"]),
        
        Phoneme(letter: "l", symbol: "/l/", description: "leaf", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Press the tip of your tongue against the ridge behind your upper front teeth."),
            TipModel(title: "3. Sound", description: "Let air flow around the sides of your tongue.")
        ], words: ["like", "fall", "help", "please", "close"], soundFile: "l", icon: "leaf.fill", video: ["mouth_l_1", "mouth_l_2", "mouth_l_3", "mouth_l_4", "mouth_l_5"]),

        Phoneme(letter: "ch", symbol: "/ʧ/", description: "chair", tips: [
            TipModel(title: "1. Lips", description: "Round your lips slightly."),
            TipModel(title: "2. Tongue", description: "Touch the tip of your tongue to the roof of your mouth briefly."),
            TipModel(title: "3. Sound", description: "Combine a 't' and 'sh' sound as you release the air.")
        ], words: ["choose", "which", "watch", "change"], soundFile: "ʧ", icon: "chair.fill", video: ["mouth_ʧ_1", "mouth_ʧ_2", "mouth_ʧ_3", "mouth_ʧ_4", "mouth_ʧ_5", "mouth_ʧ_6", "mouth_ʧ_7"]),
        
        Phoneme(letter: "ʒ", symbol: "/ʒ/", description: "vision", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Press the back of your tongue against the roof of your mouth."),
            TipModel(title: "3. Vibration", description: "Feel the vibration in your throat as you release the air.")
        ], words: ["genre", "pleasure", "beige"], soundFile: "ʒ", icon: "visionpro", video: ["mouth_ʒ_1", "mouth_ʒ_2", "mouth_ʒ_3", "mouth_ʒ_4", "mouth_ʒ_5", "mouth_ʒ_6", "mouth_ʒ_7"]),
        
        Phoneme(letter: "z", symbol: "/z/", description: "zipper", tips: [
            TipModel(title: "1. Lips", description: "Spread your lips slightly."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue close to the upper front teeth."),
            TipModel(title: "3. Vibration", description: "Feel a buzzing vibration in your throat as you blow air.")
        ], words: ["close", "business", "please", "exactly"], soundFile: "z", icon: "doc.zipper", video: ["mouth_z_1", "mouth_z_2", "mouth_z_3", "mouth_z_4", "mouth_z_5", "mouth_z_6", "mouth_z_7"])
    ]
    
    func selectPhoneme(_ phoneme: Phoneme) {
        print("Selected phoneme: \(phoneme.symbol)")
    }
}
