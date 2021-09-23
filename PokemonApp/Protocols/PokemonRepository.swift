//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI
import Combine

protocol PokemonRepositoryType {
    
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<Pokedex, Error>?
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>?

    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>?
    
}
