//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    
    private var subscribers: Set<AnyCancellable> = []
    
    let limit: Int
    let offset: Int
    let pokemonRepo: PokemonRepositoryType
    
    init(limit: Int,
         offset: Int,
         pokemonRepo: PokemonRepositoryType = APIPokemonRepository()
    ) {
        self.limit = limit
        self.offset = offset
        self.pokemonRepo = pokemonRepo
        fetchPokemons()
    }
    
    func fetchPokemons() {
        self.isLoading = true
        
        pokemonRepo.getPokemonsURLFromAGeneration(limit: limit, offset: offset)?
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    // IDK WHAT TO DO HERE
                    break
                case .failure(let error):
                    self?.isLoading = false
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] pokedex in
                for pokemon in pokedex.results {
                    self?.getSinglePokemon(url: pokemon.url ?? "")
                }
            }
            .store(in: &subscribers)
    }
    
    func getSinglePokemon(url: String) {
        pokemonRepo.getASinglePokemon(url: url)?
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    // IDK WHAT TO DO HERE
                    break
                case .failure(let error):
                    self?.isLoading = false
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] pokemon in
                self?.pokemons.append(pokemon)
                self?.pokemons.sort { $0.id < $1.id }
                self?.isLoading = false
            }
            .store(in: &subscribers)
    }
}
