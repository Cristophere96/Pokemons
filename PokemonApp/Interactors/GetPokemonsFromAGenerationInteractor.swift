//
//  GetPokemonsFromAGenerationInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine

class GetPokemonsFromAGenerationInteractor {
    private var repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        return self.repository.getPokemonsURLFromAGeneration(limit: limit, offset: offset)
    }}
