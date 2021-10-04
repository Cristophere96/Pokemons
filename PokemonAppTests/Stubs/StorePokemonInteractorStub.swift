//
//  StorePokemonInteractorStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 4/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class StorePokemonInteractorStub: StorePokemonInteractorType {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    var responseHandler: InteractorStubCase<Any> = .success({})
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>? {
        var publisher = CurrentValueSubject<Bool, Error>(false)
        
        switch responseHandler {
        case .success(let handler):
            publisher = CurrentValueSubject<Bool, Error>(handler() as? Bool ?? true)
        case .failure(let error):
            publisher.send(completion: .failure(error()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
