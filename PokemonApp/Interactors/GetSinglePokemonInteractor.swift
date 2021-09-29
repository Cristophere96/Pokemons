//
//  GetSinglePokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/09/21.
//

import SwiftUI
import Combine

class GetASinglePokemonInteractor {
    private var repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        return self.repository.getASinglePokemon(url: url)
    }
}
