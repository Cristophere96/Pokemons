//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI
import Combine

class PokemonVotingViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.viewContext
    
    @Published var pokemon = [Pokemon]()
    @Published var isLoading: Bool = false
    let pokemonRepo: PokemonRepositoryType
    private var subscribers: Set<AnyCancellable> = []
    
    init(pokemonRepo: PokemonRepositoryType = APIPokemonRepository()) {
        self.pokemonRepo = pokemonRepo
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
        let new = PokemonsVoted(context: self.viewContext)
        new.url = "\(Constants.urlsName.pokemonURLBase)/\(pokemon[0].id)"
        new.voteType = type
        
        do {
            try self.viewContext.save()
            fetchSinglePokemon()
        } catch {
            print("Unresolved error: \(error)")
        }
    }
    
    func savePokemon(type: String) {
        let pokemonsVoted: [PokemonsVoted] = PersistenceController.shared.getAllPokemonsVoted()
        
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
