//
//  TongueTwisters.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import Foundation

let tongueTwisters: [String] = [
    "Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked. If Peter Piper picked a peck of pickled peppers, where’s the peck of pickled peppers Peter Piper picked?",
    "Betty Botter bought some butter. But she said the butter’s bitter. If I put it in my batter, it will make my batter bitter. But a bit of better butter will make my batter better. So ‘twas better Betty Botter bought a bit of better butter.",
    "How much wood would a woodchuck chuck if a woodchuck could chuck wood? He would chuck, he would, as much as he could, and chuck as much wood as a woodchuck would if a woodchuck could chuck wood.",
    "She sells seashells on the seashore. The shells she sells are seashells, I’m sure. And if she sells seashells on the seashore, then I’m sure she sells seashore shells.",
    "Birdie birdie in the sky laid a turdie in my eye. If cows could fly I’d have a cow pie in my eye.",
    "How much ground would a groundhog hog, if a groundhog could hog ground? A groundhog would hog all the ground he could hog, if a groundhog could hog ground.",
    "If you must cross a course cross cow across a crowded cow crossing, cross the cross coarse cow across the crowded cow crossing carefully.",
    "When a doctor doctors a doctor, does the doctor doing the doctoring doctor as the doctor being doctored wants to be doctored, or does the doctor doing the doctoring doctor as he wants to doctor?",
    "A skunk sat on a stump and thunk the stump stunk, but the stump thunk the skunk stunk.",
    "Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons—balancing them badly."
]

func randomTongueTwister() -> String? {
    return tongueTwisters.randomElement()
}

//if let twister = randomTongueTwister() {
//    print("Try this one: \(twister)")
//}
