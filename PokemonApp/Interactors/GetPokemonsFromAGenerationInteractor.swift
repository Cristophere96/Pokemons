//
//  GetPokemonsFromAGenerationInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine
import Resolver

protocol GetPokemonsFromAGenerationInteractorType {
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>?
}

class GetPokemonsFromAGenerationInteractor: GetPokemonsFromAGenerationInteractorType {
    @Injected var repository: PokemonRepositoryType
    
    init() {  }
    
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        return self.repository.getPokemonsURLFromAGeneration(limit: limit, offset: offset)
    }}
