//
//  CoreDataPokemonRepositoryInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/09/21.
//

import SwiftUI
import Combine

class CoreDataPokemonRepositoryInteractor: PokemonDataBaseRepositoryType {
    private var repository: PokemonDataBaseRepositoryType
    
    init(repository: PokemonDataBaseRepositoryType = CoreDataPokemonRepository()) {
        self.repository = repository
    }
    
    func getAllPokemonsFromCoreData(completion: @escaping (Result<[PokemonsVoted], Error>) -> Void) {
        self.repository.getAllPokemonsFromCoreData(completion: completion)
    }
    
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.repository.savePokemonToCoreData(url: url, type: type, completion: completion)
    }
}
