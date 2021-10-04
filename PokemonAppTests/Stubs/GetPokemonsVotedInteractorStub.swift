//
//  GetPokemonsVotedInteractorStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class GetPokemonsVotedInteractorStub: GetPokemonsVotedInteractorType {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    var responseHandler: InteractorStubCase<Any> = .success({})
    
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        let objects = TestsConstants.mockPokemonsVoted
        
        var publisher = CurrentValueSubject<[DPokemonsVoted], Error>(objects)
        
        switch responseHandler {
        case .success(let handler):
            publisher = CurrentValueSubject<[DPokemonsVoted], Error>(handler() as? [DPokemonsVoted] ?? objects)
        case .failure(let error):
            publisher.send(completion: .failure(error()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
