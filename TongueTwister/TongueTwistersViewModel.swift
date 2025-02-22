//
//  TongueTwistersViewModel.swift
//  Speeches
//
//  Created by Layza Maria Rodrigues Carneiro on 20/02/25.
//

import SwiftUI

struct AccuracyEntry: Identifiable {
    let id: UUID
    let value: Double
}

class TongueTwisterViewModel: ObservableObject {
    
    @Published var tongueTwisters: [TongueTwisterModel] = [
        TongueTwisterModel(title: "1", text: "Lovely lizards licking lusciously ripe lychees"),
        TongueTwisterModel(title: "2", text: "The weathered leather that the father gathered was rather thinner than the other leather, though both were thought to be the best."),
        TongueTwisterModel(title: "3", text: "Little Larry lost his lucky lantern, looking left, looking right, but landing last in the little lake."),
        TongueTwisterModel(title: "4", text: "Lovely Lucy loves lemon lollipops, licking lightly as she lounges lazily under the large leafy lime tree."),
        TongueTwisterModel(title: "5", text: "Richard the rabbit ran right round the rickety road, reaching the rusty railway rails before the roaring rain arrived."),
        TongueTwisterModel(title: "6", text: "Round and round the rugged rocks, the restless river rushes, roaring rapidly as red robins race to rest in the rustling reeds."),
        TongueTwisterModel(title: "7", text: "Gary’s gray goose gobbles green grass greedily, grumbling as the gusty wind grows stronger by the great golden gate."),
        TongueTwisterModel(title: "8", text: "Great green grapes grow in Grandma’s garden, glistening under the golden glow of the gentle morning sun."),
        TongueTwisterModel(title: "9", text: "The lazy lizard lies on the zigzagging fence, as buzzing bees breeze by the dazzling daisies in the hazy sunlight."),
        TongueTwisterModel(title: "10", text: "Zebra zooms through the zoo, zigzagging between zany zebras and zipping past buzzing bees with zero hesitation."),
        TongueTwisterModel(title: "11", text: "Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked. If Peter Piper picked a peck of pickled peppers, where’s the peck of pickled peppers Peter Piper picked?"),
        TongueTwisterModel(title: "12", text: "There are those thousand thinkers who were thinking how did the other three thieves go through."),
        TongueTwisterModel(title: "13", text: "She sells seashells on the seashore. The shells she sells are seashells, I’m sure. And if she sells seashells on the seashore, then I’m sure she sells seashore shells."),
        TongueTwisterModel(title: "14", text: "How much ground would a groundhog hog, if a groundhog could hog ground? A groundhog would hog all the ground he could hog, if a groundhog could hog ground."),
        TongueTwisterModel(title: "15", text: "If you must cross a course cross cow across a crowded cow crossing, cross the cross coarse cow across the crowded cow crossing carefully."),
        TongueTwisterModel(title: "16", text: "Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons—balancing them badly."),
        TongueTwisterModel(title: "17", text: "Six slippery snails slowly slid south, seeking shelter from sudden storms, but some stayed still, staring at the silver sea."),
        TongueTwisterModel(title: "18", text: "Sam's sister sells seven silky scarves, some striped, some solid, some shimmering in the summer sun."),
        TongueTwisterModel(title: "19", text: "Shelly shivered as she shuffled through the shady shore, searching for shimmering shells to share with her shy shadow.")
    ]
    
    func randomTongueTwister() -> TongueTwisterModel? {
        return tongueTwisters.randomElement()
    }
}

//"The weathered leather that the father gathered was rather thinner than the other leather, though both were thought to be the best.",
//"Little Larry lost his lucky lantern, looking left, looking right, but landing last in the little lake.",
//"Lovely Lucy loves lemon lollipops, licking lightly as she lounges lazily under the large leafy lime tree.",
//"Richard the rabbit ran right round the rickety road, reaching the rusty railway rails before the roaring rain arrived.",
//"Round and round the rugged rocks, the restless river rushes, roaring rapidly as red robins race to rest in the rustling reeds.",
//"Gary’s gray goose gobbles green grass greedily, grumbling as the gusty wind grows stronger by the great golden gate.",
//"Great green grapes grow in Grandma’s garden, glistening under the golden glow of the gentle morning sun.",
//"The lazy lizard lies on the zigzagging fence, as buzzing bees breeze by the dazzling daisies in the hazy sunlight.",
//"Zebra zooms through the zoo, zigzagging between zany zebras and zipping past buzzing bees with zero hesitation.",
//"Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked. If Peter Piper picked a peck of pickled peppers, where’s the peck of pickled peppers Peter Piper picked?",
//"There are those thousand thinkers were thinking how did the other three thieves go through.",
//"She sells seashells on the seashore. The shells she sells are seashells, I’m sure. And if she sells seashells on the seashore, then I’m sure she sells seashore shells.",
//"How much ground would a groundhog hog, if a groundhog could hog ground? A groundhog would hog all the ground he could hog, if a groundhog could hog ground.",
//"If you must cross a course cross cow across a crowded cow crossing, cross the cross coarse cow across the crowded cow crossing carefully.",
//"Brisk brave brigadiers brandished broad bright blades, blunderbusses, and bludgeons—balancing them badly.",
//"Six slippery snails slowly slid south, seeking shelter from sudden storms, but some stayed still, staring at the silver sea.",
//"Sam's sister sells seven silky scarves, some striped, some solid, some shimmering in the summer sun.",
//"Shelly shivered as she shuffled through the shady shore, searching for shimmering shells to share with her shy shadow."
