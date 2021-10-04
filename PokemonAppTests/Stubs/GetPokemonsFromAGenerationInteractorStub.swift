//
//  GetPokemonsFromAGenerationInteractorStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class GetPokemonsFromAGenerationInteractorStub: GetPokemonsFromAGenerationInteractorType {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    var responseHandler: InteractorStubCase<Any> = .success({})
    
    
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        let objects = TestsConstants.mockedPokemons
        
        var publisher = CurrentValueSubject<[Pokemon], Error>(objects)
        
        switch responseHandler {
        case .success(let handler):
            publisher = CurrentValueSubject<[Pokemon], Error>(handler() as? [Pokemon] ?? objects )
        case .failure(let error):
            publisher.send(completion: .failure(error()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
