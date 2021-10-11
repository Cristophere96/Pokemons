//
//  GetASinglePokemonInteractorStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class GetASinglePokemonInteractorStub: GetASinglePokemonInteractorType {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    var responseHandler: InteractorStubCase<Any> = .success({})
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let object = TestsConstants.mockedPokemon
        var publisher = CurrentValueSubject<Pokemon, Error>(object)
        
        switch responseHandler {
        case .success(let handler):
            publisher = CurrentValueSubject<Pokemon, Error>(handler() as? Pokemon ?? object)
        case .failure(let error):
            publisher.send(completion: .failure(error()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
