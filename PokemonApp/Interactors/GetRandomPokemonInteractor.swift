//
//  GetRandomPokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/09/21.
//

import SwiftUI
import Combine
import Resolver

protocol GetRandomPokemonInteractorType {
    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>?
}

class GetRandomPokemonInteractor: GetRandomPokemonInteractorType {
    @Injected var repository: PokemonRepositoryType
    
    init() {  }
    
    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>? {
         let randomNumber = Int.random(in: 1..<894)
        let url = "\(Constants.urlsName.pokemonURLBase)/\(randomNumber)"
        
        return self.repository.getRandomPokemon(url: url)
    }
}
