//
//  PokemonsVotedViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI
import Combine

class PokemonsVotedViewModel: ObservableObject {
    private var pokemonsVoted: [PokemonsVoted] = []
    
    @Published var pokemons = [Pokemon]()
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    
    private var subscribers: Set<AnyCancellable> = []
    
    let pokemonRepo: PokemonRepositoryType
    let pokemonsStoredRepo: PokemonDataBaseRepositoryType
    
    init(pokemonRepo: PokemonRepositoryType = APIPokemonRepository(),
         pokemonsStoredRepo: PokemonDataBaseRepositoryType = CoreDataPokemonRepository()
    ) {
        self.pokemonRepo = pokemonRepo
        self.pokemonsStoredRepo = pokemonsStoredRepo
        getAllPokemonsVoted()
        fetchPokemons()
    }
    
    func getAllPokemonsVoted() {
        pokemonsStoredRepo.getAllPokemonsFromCoreData { result in
            switch result {
            case .success(let pokemonsStored):
                self.pokemonsVoted = pokemonsStored
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPokemons() {
        if pokemonsVoted.isEmpty {
            self.isEmpty = true
        } else {
            self.isEmpty = false
            self.isLoading = true
            for pokemonVoted in pokemonsVoted {
                pokemonRepo.getASinglePokemon(url: pokemonVoted.url ?? "")?
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
                        var exist: Bool = false
                        for _pokemon in self?.pokemons ?? [] {
                            if pokemon.id == _pokemon.id {
                                exist = true
                            }
                        }
                        if !exist {
                            self?.pokemons.append(pokemon)
                            self?.pokemons.sort { $0.id < $1.id }
                            self?.isLoading = false
                        }
                    }
                    .store(in: &subscribers)
            }
            self.isLoading = false
        }
    }
}
