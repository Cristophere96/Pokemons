//
//  GetRandomPokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/09/21.
//

import SwiftUI
import Combine

class GetRandomPokemonInteractor {
    private var repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>? {
        let randomNumber = Int.random(in: 1..<894)
        let url = "\(Constants.urlsName.pokemonURLBase)/\(randomNumber)"
        
        return self.repository.getRandomPokemon(url: url)
    }
}
