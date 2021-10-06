//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI
import Combine

protocol PokemonRepositoryType {
    
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>?
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>

    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>?
    
}
