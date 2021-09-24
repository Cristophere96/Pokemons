//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI
import Combine

class PokemonVotingViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    @Published var isLoading: Bool = false
    let pokemonRepo: PokemonRepositoryType
    let pokemonsStoredRepo: PokemonDataBaseRepositoryType
    private var subscribers: Set<AnyCancellable> = []
    
    init(pokemonRepo: PokemonRepositoryType = APIPokemonRepository(),
         pokemonsStoredRepo: PokemonDataBaseRepositoryType = CoreDataPokemonRepository()) {
        self.pokemonRepo = pokemonRepo
        self.pokemonsStoredRepo = pokemonsStoredRepo
        fetchSinglePokemon()
    }
    
    func fetchSinglePokemon() {
        self.isLoading = true
        pokemonRepo.getRandomPokemon()?
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
                self?.pokemon = [pokemon]
                self?.isLoading = false
            }
            .store(in: &subscribers)
    }
    
    func saveToCoreData(type: String) {
        pokemonsStoredRepo.savePokemonToCoreData(url: "\(Constants.urlsName.pokemonURLBase)/\(pokemon[0].id)", type: type) { result in
            switch result {
            case .success(_):
                self.fetchSinglePokemon()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func savePokemon(type: String) {
        var pokemonsVoted: [PokemonsVoted] = []
        
        pokemonsStoredRepo.getAllPokemonsFromCoreData { result in
            switch result {
            case .success(let pokemonsStored):
                pokemonsVoted = pokemonsStored
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        
        if pokemonsVoted.count == 0 {
            saveToCoreData(type: type)
        } else {
            var exist: Bool = false
            for item in pokemonsVoted {
                if item.url == "\(Constants.urlsName.pokemonURLBase)/\(pokemon[0].id)" {
                   exist = true
                }
            }
            
            if exist {
                fetchSinglePokemon()
            } else {
                saveToCoreData(type: type)
            }
        }
    }
    
    func likePokemon() {
        savePokemon(type: "LIKE")
    }
    
    func dislikePokemon() {
        savePokemon(type: "DISLIKE")
    }
}
