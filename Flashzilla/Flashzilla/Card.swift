//
//  Card.swift
//  Flashzilla
//
//  Created by Oliwier Kasprzak on 01/04/2023.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "What is the world's city of sin?", answer: "Las Vegas")
}
