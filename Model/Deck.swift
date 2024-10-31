//
//  Deck.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/22/24.
//

import Foundation

struct Deck: Codable{
    var language: String
    var category: String
    var notecards: [Notecard]
    
}
