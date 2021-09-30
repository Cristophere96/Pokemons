//
//  GetPokemonsVotedInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine
import Resolver

protocol GetPokemonsVotedInteractorType {
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>?
}

class GetPokemonsVotedInteractor: GetPokemonsVotedInteractorType {
    @Injected var repository: PokemonDataBaseRepositoryType
    
    init() {  }
    
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        return self.repository.getAllPokemonsFromCoreData()
    }
}
