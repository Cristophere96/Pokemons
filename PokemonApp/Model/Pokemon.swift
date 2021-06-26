//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import Foundation

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
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}
