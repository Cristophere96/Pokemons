//
//  APIPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI
import Combine
import Resolver

class APIPokemonRepository: PokemonRepositoryType {
    @Injected var service: PokemonServiceType
    
    init() {  }
    
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        return service.getPokemonsFromAGeneration(limit: limit, offset: offset)
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        return service.getASinglePokemon(url: url)
    }

    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        return service.getRandomPokemon(url: url)
    }
    
}
