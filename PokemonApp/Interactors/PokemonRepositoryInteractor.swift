//
//  PokemonRepositoryInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine

class PokemonRepositoryInteractor: PokemonRepositoryType {
    
    private var repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType = APIPokemonRepository()) {
        self.repository = repository
    }
    
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<Pokedex, Error>? {
        return self.repository.getPokemonsURLFromAGeneration(limit: limit, offset: offset)
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        return self.repository.getASinglePokemon(url: url)
    }
    
    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>? {
        return self.repository.getRandomPokemon()
    }
}
