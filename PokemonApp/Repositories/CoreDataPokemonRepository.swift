//
//  CoreDataPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI
import Combine
import Resolver

class CoreDataPokemonRepository: PokemonDataBaseRepositoryType {
    @Injected var service: CoreDataServiceType
    
    init() {  }
    
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        return service.getAllPokemonsFromCoreData()
    }
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>? {
        return service.savePokemonToCoreData(url: url, type: type)
    }
}
