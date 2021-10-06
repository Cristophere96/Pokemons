//
//  PokemonService.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import SwiftUI
import Combine

protocol PokemonServiceType {
    
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>?
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>

    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>?
    
}
