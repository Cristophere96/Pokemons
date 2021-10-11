//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import Foundation
import Combine

struct Pokedex: Decodable {    
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}

struct Pokemon: Decodable, Identifiable {
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
    let stats: [Stat]
}

struct Species: Decodable {
    let name: String
    let url: String
}

struct GameIndex: Decodable {
    let gameIndex: Int
    let version: Species
}

struct Move: Decodable {
    let move: Species
}

struct Sprites: Decodable {
    let front_default: String
    let other: Other?
}

struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}

struct Stat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Species
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct Other: Decodable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
