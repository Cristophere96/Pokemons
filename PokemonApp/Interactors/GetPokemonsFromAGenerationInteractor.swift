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
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>?
}

class GetPokemonsFromAGenerationInteractor: GetPokemonsFromAGenerationInteractorType {
    @Injected var repository: PokemonRepositoryType
    
    init() {  }
    
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        return self.repository.getPokemonsFromAGeneration(limit: limit, offset: offset)
    }}
