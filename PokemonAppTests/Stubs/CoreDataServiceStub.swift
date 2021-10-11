//
//  CoreDataServiceStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 7/10/21.
//

import Combine
import Resolver
@testable import PokemonApp

final class CoreDataServiceStub {
    static var error: Error?
    static var response: Any!
}

extension CoreDataServiceStub: CoreDataServiceType {
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        let data = CoreDataServiceStub.response ?? TestsConstants.mockPokemonsVoted
        let publisher = CurrentValueSubject<[DPokemonsVoted], Error>(data as? [DPokemonsVoted] ?? TestsConstants.mockPokemonsVoted)
        
        if let error = CoreDataServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>? {
        let response = CoreDataServiceStub.response ?? true
        let publisher = CurrentValueSubject<Bool, Error>(response as? Bool ?? true)
        
        if let error = CoreDataServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
