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
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue at the front of the top of your mouth, behind where the /s/ is produced."),
            TipModel(title: "2. Respiration", description: "Push air between the top of your mouth and the tip of your tongue."),
            TipModel(title: "3. Vibration", description: "Do not vibrate your vocal cords.")
        ], words: ["shop", "dash", "issue", "sugar", "motion", "pushed"], soundFile: "ʃ", icon: "sailboat.fill", video: ["mouth_ʃ_1", "mouth_ʃ_2", "mouth_ʃ_3", "mouth_ʃ_4", "mouth_ʃ_5", "mouth_ʃ_6", "mouth_ʃ_7"]),
        
        Phoneme(letter: "s", symbol: "/s/", description: "sun", tips: [
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue lightly against the ridge behind your upper teeth (but do not touch the teeth)."),
            TipModel(title: "2. Respiration", description: "As you push air out of your mouth, squeeze the air between the tip of your tongue and the top of your mouth."),
            TipModel(title: "3. Vibration", description: "You should feel some friction (resistance). Do not vibrate your vocal cords as you make this sound.")
        ], words: ["sample", "stocks", "past", "race", "slip", "strong"], soundFile: "s", icon: "sun.max.fill", video: ["mouth_s_1", "mouth_s_2", "mouth_s_3", "mouth_s_4", "mouth_s_5", "mouth_s_6", "mouth_s_7"]),
        
        Phoneme(letter: "θ", symbol: "/θ/", description: "think", tips: [
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue between your upper and lower teeth."),
            TipModel(title: "2. Respiration", description: "Push air out of your mouth between your tongue and your teeth."),
            TipModel(title: "3. Vibration", description: "You should feel some friction (resistance). Do not vibrate your vocal cords.")
        ], words: ["thanks", "thought", "bath", "fifth", "nothing"], soundFile: "θ", icon: "cloud.fill", video: ["mouth_θ_1", "mouth_θ_2", "mouth_θ_3", "mouth_θ_4", "mouth_θ_5"]),
        
        Phoneme(letter: "ð", symbol: "/ð/", description: "this", tips: [
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue between your upper and lower teeth."),
            TipModel(title: "2. Respiration", description: "Push air out of your mouth between your tongue and your teeth. You should feel some friction (resistance)."),
            TipModel(title: "3. Vibration", description: "Vibrate your vocal cords.")
        ], words: ["the", "either", "breathe", "therefore"], soundFile: "ð", icon: "hand.point.up.left.fill", video: ["mouth_ð_1", "mouth_ð_2", "mouth_ð_3", "mouth_ð_4", "mouth_ð_5"]),
        
        Phoneme(letter: "r", symbol: "/r/", description: "rabbit", tips: [
            TipModel(title: "1. Key", description: "The key to making /r/ is not letting the tip of your tongue touch the roof of your mouth. If you do touch, listeners may hear an /l/ sound instead."),
            TipModel(title: "2. Tongue", description: "Pull your tongue back so the tip is positioned around center of your mouth. Point the tip up slightly."),
            TipModel(title: "3. Vibration", description: "Now, vibrate your vocal cords and let the air flow around and over your tongue.")
        ], words: ["store", "third", "track", "start", "ring", "rocket"], soundFile: "r", icon: "hare.fill", video: ["mouth_r_1", "mouth_r_2", "mouth_r_3", "mouth_r_4", "mouth_r_5", "mouth_r_6"]),
        
        Phoneme(letter: "l", symbol: "/l/", description: "leaf", tips: [
            TipModel(title: "1. Tongue", description: "The tip of your tongue should touch the top of your mouth, behind your teeth."),
            TipModel(title: "2. Vibration", description: "Now, vibrate your vocal cords and let the air flow around the sides of your tongue."),
            TipModel(title: "3. Note", description: "For /l/ at the end of a word, the back of your tongue will also rise slightly (but not touch the top of your mouth).")
        ], words: ["like", "fall", "help", "please", "close"], soundFile: "l", icon: "leaf.fill", video: ["mouth_l_1", "mouth_l_2", "mouth_l_3", "mouth_l_4", "mouth_l_5"]),

        Phoneme(letter: "ch", symbol: "/ʧ/", description: "chair", tips: [
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue just behind the hard ridge at the front of the top of your mouth."),
            TipModel(title: "2. Respiration", description: "Push air forward out of your mouth. Stop the air completely at first, and then release it. After release, the air should create friction between the tip of your tongue and the roof of your mouth."),
            TipModel(title: "3. Vibration", description: "Do not vibrate your vocal cords when you make this sound; it’s voiceless.")
        ], words: ["choose", "which", "watch", "change"], soundFile: "ʧ", icon: "chair.fill", video: ["mouth_ʧ_1", "mouth_ʧ_2", "mouth_ʧ_3", "mouth_ʧ_4", "mouth_ʧ_5", "mouth_ʧ_6", "mouth_ʧ_7"]),
        
        Phoneme(letter: "ʒ", symbol: "/ʒ/", description: "vision", tips: [
            TipModel(title: "1. Tongue", description: "Place the tip of your tongue at the front of the top of your mouth, behind where the /s/ is produced."),
            TipModel(title: "2. Vibration", description: "Vibrate your vocal cords as you push air between the top of your mouth and the tip of your tongue."),
            TipModel(title: "", description: "")
        ], words: ["genre", "pleasure", "beige"], soundFile: "ʒ", icon: "visionpro", video: ["mouth_ʒ_1", "mouth_ʒ_2", "mouth_ʒ_3", "mouth_ʒ_4", "mouth_ʒ_5", "mouth_ʒ_6", "mouth_ʒ_7"]),
        
        Phoneme(letter: "z", symbol: "/z/", description: "zipper", tips: [
            TipModel(title: "1. Tongue", description: "Place the blade of your tongue (just behind the tip) very close to the roof of your mouth, behind your teeth."),
            TipModel(title: "2. Attention", description: "There should be a little space between your tongue and the roof of your mouth."),
            TipModel(title: "3. Vibration", description: "Now, vibrate your vocal cords and push the air between your tongue and the roof of your mouth. You will feel some resistance.")
        ], words: ["close", "business", "please", "exactly"], soundFile: "z", icon: "doc.zipper", video: ["mouth_z_1", "mouth_z_2", "mouth_z_3", "mouth_z_4", "mouth_z_5", "mouth_z_6", "mouth_z_7"])
    ]
    
    func selectPhoneme(_ phoneme: Phoneme) {
        print("Selected phoneme: \(phoneme.symbol)")
    }
}
