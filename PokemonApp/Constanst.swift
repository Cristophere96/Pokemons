//
//  Constanst.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI

public struct Constants {
    enum urlsName {
        static let pokemonURLBase = "https://pokeapi.co/api/v2/pokemon"
    }
    
    enum VoteTypes: String, CaseIterable {
        case LIKED = "LIKED"
        case DISLIKED = "DISLIKED"
    }
    
    static let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
}
