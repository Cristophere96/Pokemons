//
//  CoreDataPokemonRepositoryStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class CoreDataPokemonRepositoryStub {
    static var error: Error?
    static var response: Any!
}

extension CoreDataPokemonRepositoryStub: PokemonDataBaseRepositoryType {
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        let data = CoreDataPokemonRepositoryStub.response ?? TestsConstants.mockPokemonsVoted
        let publisher = CurrentValueSubject<[DPokemonsVoted], Error>(data as? [DPokemonsVoted] ?? TestsConstants.mockPokemonsVoted)
        
        if let error = CoreDataPokemonRepositoryStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>? {
        let response = CoreDataPokemonRepositoryStub.response ?? true
        let publisher = CurrentValueSubject<Bool, Error>(response as? Bool ?? true)
        
        if let error = CoreDataPokemonRepositoryStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
}
