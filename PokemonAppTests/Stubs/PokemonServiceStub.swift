//
//  PokemonServiceStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import Combine
import Resolver
@testable import PokemonApp

final class PokemonServiceStub {
    static var error: Error?
    static var response: Any!
}

extension PokemonServiceStub: PokemonServiceType {
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        let data = PokemonServiceStub.response ?? TestsConstants.mockedPokemons
        let publisher = CurrentValueSubject<[Pokemon], Error>(data as? [Pokemon] ?? TestsConstants.mockedPokemons)
        
        if let error = PokemonServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let data = PokemonServiceStub.response ?? TestsConstants.mockedPokemon
        let publiser = CurrentValueSubject<Pokemon, Error>(data as? Pokemon ?? TestsConstants.mockedPokemon)
        
        if let error = PokemonServiceStub.error {
            publiser.send(completion: .failure(error))
        }
        return publiser.eraseToAnyPublisher()
    }
    
    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        let data = PokemonServiceStub.response ?? TestsConstants.mockedPokemons
        let publisher = CurrentValueSubject<Pokemon, Error>(data as? Pokemon ?? TestsConstants.mockedPokemon)
        
        if let error = PokemonServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
}
