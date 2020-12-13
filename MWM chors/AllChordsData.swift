//
//  AllChordsData.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

import Foundation

struct AllChordsData: Decodable {
    let keys: [Key]
    let chords: [Chord]
    
    enum CodingKeys: String, CodingKey {
        case keys = "allkeys"
        case chords = "allchords"
    }
}

struct Key: Decodable {
    let id: Int
    let name: String
    let chordIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "keyid"
        case name
        case chordIds = "keychordids"
    }
}

struct Chord: Decodable {
    let id: Int
    let suffix: String
    let midi: [Int]
    let fingers: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "chordid"
        case suffix
        case midi
        case fingers
    }
}
