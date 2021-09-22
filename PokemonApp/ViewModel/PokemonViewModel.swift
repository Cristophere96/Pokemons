//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var isLoading: Bool = false
    
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
        
        pokemonRepo.getAllPokemonsFromAGeneration(limit: limit, offset: offset) { result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self.pokemons = pokemons
                    self.isLoading = false
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
