//
//  APIPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI
import Combine

class APIPokemonRepository: PokemonRepositoryType {
    func getPokemonsURLFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<Pokedex, Error>? {
        guard let url = URL(string: "\(Constants.urlsName.pokemonURLBase)?limit=\(limit)&offset=\(offset)") else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        guard let url = URL(string: url) else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getRandomPokemon() -> AnyPublisher<Pokemon, Error>? {
        let number = Int.random(in: 1..<894)
        guard let url = URL(string: "\(Constants.urlsName.pokemonURLBase)/\(number)") else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
