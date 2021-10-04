//
//  TestsConstants.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 1/10/21.
//

import SwiftUI

public struct TestsConstants {
    
    static let mockedMoves: [Move] = [
        Move(move: Species(name: "cut", url: "https://pokeapi.co/api/v2/move/15/")),
        Move(move: Species(name:"double-kick", url:"https://pokeapi.co/api/v2/move/24/")),
        Move(move: Species(name:"headbutt", url:"https://pokeapi.co/api/v2/move/29/")),
        Move(move: Species(name:"tackle", url:"https://pokeapi.co/api/v2/move/33/")),
        Move(move: Species(name:"body-slam", url:"https://pokeapi.co/api/v2/move/34/"))
    ]
    
    static let mockedSprites = Sprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/155.png"
    )
    
    static let mockedTypes: [TypeElement] = [
        TypeElement(slot: 1, type: Species(name: "fire", url: "https://pokeapi.co/api/v2/type/10/"))
    ]
    
    static let mockedPokemon = Pokemon(height: 5, id: 155, moves: mockedMoves, name: "cyndaquill", sprites: mockedSprites, types: mockedTypes, weight: 79)
    
    static let mockedPokemons: [Pokemon] = [
        Pokemon(height: 9, id: 152, moves: mockedMoves, name: "chikorita", sprites: mockedSprites, types: mockedTypes, weight: 64),
        Pokemon(height: 12, id: 153, moves: mockedMoves, name: "bayleef", sprites: mockedSprites, types: mockedTypes, weight: 158),
        Pokemon(height: 18, id: 154, moves: mockedMoves, name: "meganium", sprites: mockedSprites, types: mockedTypes, weight: 1005),
        Pokemon(height: 5, id: 155, moves: mockedMoves, name: "cyndaquill", sprites: mockedSprites, types: mockedTypes, weight: 79),
        Pokemon(height: 9, id: 156, moves: mockedMoves, name: "quilava", sprites: mockedSprites, types: mockedTypes, weight: 190),
        Pokemon(height: 17, id: 157, moves: mockedMoves, name: "typhlosion", sprites: mockedSprites, types: mockedTypes, weight: 795),
        Pokemon(height: 6, id: 158, moves: mockedMoves, name: "totodile", sprites: mockedSprites, types: mockedTypes, weight: 95),
        Pokemon(height: 11, id: 159, moves: mockedMoves, name: "croconaw", sprites: mockedSprites, types: mockedTypes, weight: 250),
        Pokemon(height: 23, id: 160, moves: mockedMoves, name: "feraligatr", sprites: mockedSprites, types: mockedTypes, weight: 888),
    ]

}
