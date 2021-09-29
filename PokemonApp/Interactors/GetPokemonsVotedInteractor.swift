//
//  GetPokemonsVotedInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine

class GetPokemonsVotedInteractor {
    private var repository: PokemonDataBaseRepositoryType
    
    init(repository: PokemonDataBaseRepositoryType) {
        self.repository = repository
    }
    
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        return self.repository.getAllPokemonsFromCoreData()
    }
}
