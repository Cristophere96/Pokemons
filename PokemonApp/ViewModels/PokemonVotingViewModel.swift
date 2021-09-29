//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI
import Combine

class PokemonVotingViewModel: ObservableObject {
    @Published var pokemon : [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    let networkInteractor: GetRandomPokemonInteractor
    let pokemonsVotedInteractor: GetPokemonsVotedInteractor
    let storePokemonInteractor: StorePokemonInteractor
    private var subscribers: Set<AnyCancellable> = []
    
    init(networkInteractor: GetRandomPokemonInteractor = GetRandomPokemonInteractor(repository: APIPokemonRepository(urlSession: URLSession.shared)),
         pokemonsVotedInteractor: GetPokemonsVotedInteractor = GetPokemonsVotedInteractor(repository: CoreDataPokemonRepository()),
         storePokemonInteractor: StorePokemonInteractor = StorePokemonInteractor(repo: CoreDataPokemonRepository())
         ) {
        self.networkInteractor = networkInteractor
        self.pokemonsVotedInteractor = pokemonsVotedInteractor
        self.storePokemonInteractor = storePokemonInteractor
        fetchRandomPokemon()
    }
    
    func fetchRandomPokemon() {
        self.isLoading = true
        self.showError = false
        self.errorMessage = ""
        
        networkInteractor.getRandomPokemon()?
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.isLoading = false
                    self?.pokemon = []
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] pokemon in
                withAnimation(.easeInOut) { 
                    self?.pokemon = [pokemon]
                }
                self?.isLoading = false
            }
            .store(in: &subscribers)
    }
    
    func saveToCoreData(type: String) {
        storePokemonInteractor.savePokemonToCoreData(url: "\(Constants.urlsName.pokemonURLBase)/\(pokemon[0].id)", type: type) { result in
            switch result {
            case .success(_):
                self.fetchRandomPokemon()
            case .failure(let error):
                self.showError = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func savePokemon(type: String) {
        var pokemonsVoted: [DPokemonsVoted] = []
        
        pokemonsVotedInteractor.getAllPokemonsFromCoreData()?
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    // DO SOMETHING HERE
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { pokemonsStored in
                pokemonsVoted = pokemonsStored
            })
            .store(in: &subscribers)
        
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
                fetchRandomPokemon()
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
