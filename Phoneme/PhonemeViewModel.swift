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
        ], words: ["shop", "dash", "issue", "sugar", "motion", "pushed"], soundFile: "sh", icon: "sailboat.fill"),
        
        Phoneme(letter: "s", symbol: "/s/", description: "sun", tips: [
            TipModel(title: "1. Lips", description: "Keep your lips spread."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue close to the upper front teeth."),
            TipModel(title: "3. Respiration", description: "Blow air in a controlled stream to create a sharp hissing sound.")
        ], words: ["sample", "stocks", "past", "race", "slip", "strong"], soundFile: "s", icon: "sun.max.fill"),
        
        Phoneme(letter: "θ", symbol: "/θ/", description: "think", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue lightly between your teeth."),
            TipModel(title: "3. Respiration", description: "Blow air softly through the gap between your tongue and teeth.")
        ], words: ["thanks", "thought", "bath", "fifth", "nothing"], soundFile: "th", icon: "cloud.fill"),
        
        Phoneme(letter: "ð", symbol: "/ð/", description: "this", tips: [
            TipModel(title: "1. Lips", description: "Keep your lips neutral."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue gently between your teeth."),
            TipModel(title: "3. Vibration", description: "Feel a slight vibration in your throat as you blow air.")
        ], words: ["the", "either", "breathe", "therefore"], soundFile: "th_voice", icon: "hand.point.up.left.fill"),
        
        Phoneme(letter: "r", symbol: "/r/", description: "rabbit", tips: [
            TipModel(title: "1. Lips", description: "Slightly round your lips."),
            TipModel(title: "2. Tongue", description: "Curl the tip of your tongue upward, without touching the roof of the mouth."),
            TipModel(title: "3. Vibration", description: "Let air flow freely without any friction.")
        ], words: ["store", "third", "track", "start", "ring", "rocket"], soundFile: "r", icon: "hare.fill"),
        
        Phoneme(letter: "l", symbol: "/l/", description: "leaf", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Press the tip of your tongue against the ridge behind your upper front teeth."),
            TipModel(title: "3. Sound", description: "Let air flow around the sides of your tongue.")
        ], words: ["like", "fall", "help", "please", "close"], soundFile: "l", icon: "leaf.fill"),

        Phoneme(letter: "ch", symbol: "/ʧ/", description: "chair", tips: [
            TipModel(title: "1. Lips", description: "Round your lips slightly."),
            TipModel(title: "2. Tongue", description: "Touch the tip of your tongue to the roof of your mouth briefly."),
            TipModel(title: "3. Sound", description: "Combine a 't' and 'sh' sound as you release the air.")
        ], words: ["choose", "which", "watch", "change"], soundFile: "s", icon: "chair.fill"),
        
        Phoneme(letter: "ʒ", symbol: "/ʒ/", description: "vision", tips: [
            TipModel(title: "1. Lips", description: "Relax your lips."),
            TipModel(title: "2. Tongue", description: "Press the back of your tongue against the roof of your mouth."),
            TipModel(title: "3. Vibration", description: "Feel the vibration in your throat as you release the air.")
        ], words: ["genre", "pleasure", "beige"], soundFile: "s", icon: "visionpro"),
        
        Phoneme(letter: "z", symbol: "/z/", description: "zipper", tips: [
            TipModel(title: "1. Lips", description: "Spread your lips slightly."),
            TipModel(title: "2. Tongue", description: "Place the tip of your tongue close to the upper front teeth."),
            TipModel(title: "3. Vibration", description: "Feel a buzzing vibration in your throat as you blow air.")
        ], words: ["close", "business", "please", "exactly"], soundFile: "s", icon: "doc.zipper")
    ]
    
    func selectPhoneme(_ phoneme: Phoneme) {
        print("Selected phoneme: \(phoneme.symbol)")
    }
}
