//
//  PokemonService.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import SwiftUI
import Combine

class PokemonService: PokemonServiceType {
    
    func getPokemonsFromAGeneration(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], Error>? {
        guard let url = URL(string: "\(Constants.urlsName.pokemonURLBase)?limit=\(limit)&offset=\(offset)") else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokedex.self, decoder: JSONDecoder())
            .map { $0.results.map { self.getASinglePokemon(url: $0.url ?? "") } }
            .flatMap({ pokedex in
                Publishers.MergeMany(pokedex)
            })
            .collect()
            .eraseToAnyPublisher()
    }
    
    func getASinglePokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        let url = URL(string: url)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func getRandomPokemon(url: String) -> AnyPublisher<Pokemon, Error>? {
        guard let url = URL(string: url) else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
