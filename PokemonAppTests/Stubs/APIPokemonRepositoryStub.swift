//
//  APIPokemonRepositoryStub.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 5/10/21.
//

import Resolver
import Combine
@testable import PokemonApp

final class APIPokemonRepositoryStub {
    static var error: Error?
    static var response: Any!
}

extension APIPokemonRepositoryStub: PokemonRepositoryType {
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        let data = APIPokemonRepositoryStub.response ?? TestsConstants.mockedPokemons
        let publisher = CurrentValueSubject<[Pokemon], Error>(data as? [Pokemon] ?? TestsConstants.mockedPokemons)
        
        if let error = APIPokemonRepositoryStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let data = APIPokemonRepositoryStub.response ?? TestsConstants.mockedPokemon
        let publiser = CurrentValueSubject<Pokemon, Error>(data as? Pokemon ?? TestsConstants.mockedPokemon)
        
        if let error = APIPokemonRepositoryStub.error {
            publiser.send(completion: .failure(error))
        }
        return publiser.eraseToAnyPublisher()
    }
    
    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        let data = APIPokemonRepositoryStub.response ?? TestsConstants.mockedPokemons
        let publisher = CurrentValueSubject<Pokemon, Error>(data as? Pokemon ?? TestsConstants.mockedPokemon)
        
        if let error = APIPokemonRepositoryStub.error {
            publisher.send(completion: .failure(error))
        }
        return publisher.eraseToAnyPublisher()
    }
}
