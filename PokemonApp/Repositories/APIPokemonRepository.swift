//
//  APIPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI

class APIPokemonRepository: PokemonRepositoryType {
    func getAllPokemonsFromAGeneration(limit: Int, offset: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        var pokemons: [Pokemon] = []
        
        guard let url = URL(string: "\(Constants.urlsName.pokemonURLBase)?limit=\(limit)&offset=\(offset)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let pokedex = try? JSONDecoder().decode(Pokedex.self, from: data)
            else { return }
            
            for pokemon in pokedex.results {
                guard
                    let jsonURL = pokemon.url,
                    let eachPokemonURL = URL(string: jsonURL)
                else { return }
                
                URLSession.shared.dataTask(with: eachPokemonURL) { data, response, error in
                    guard let data = data else { return }
                    
                    do {
                        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                        pokemons.append(pokemon)
                        pokemons.sort { $0.id < $1.id }
                        completion(.success(pokemons))
                    } catch {
                        completion(.failure(error))
                    }
                }.resume()
            }
        }.resume()
    }
    
    func getASinglePokemon(url: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
