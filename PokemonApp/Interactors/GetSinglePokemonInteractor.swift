//
//  GetSinglePokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/09/21.
//

import SwiftUI
import Combine
import Resolver

protocol GetASinglePokemonInteractorType {
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>
}

class GetASinglePokemonInteractor: GetASinglePokemonInteractorType {
    @Injected var repository: PokemonRepositoryType
    
    init() {  }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        return self.repository.getASinglePokemon(url: url)
    }
}
