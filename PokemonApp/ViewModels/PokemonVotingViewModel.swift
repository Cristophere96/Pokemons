//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI
import Combine
import Resolver

class PokemonVotingViewModel: ObservableObject {
    @Published var pokemon : [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var xPosition: CGFloat = 0
    @Published var degree: Double = 0.0
    
    @Injected var networkInteractor: GetRandomPokemonInteractorType
    @Injected var pokemonsVotedInteractor: GetPokemonsVotedInteractorType
    @Injected var storePokemonInteractor: StorePokemonInteractorType
    private var subscribers: Set<AnyCancellable> = []
    
    init() {
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
        storePokemonInteractor.savePokemonToCoreData(url: "\(Constants.urlsName.pokemonURLBase)/\(pokemon[0].id)", type: type)?
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] _ in
                self?.fetchRandomPokemon()
            })
            .store(in: &subscribers)
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
        savePokemon(type: "LIKED")
        self.xPosition = 0
        self.degree = 0
    }
    
    func dislikePokemon() {
        savePokemon(type: "DISLIKED")
        self.xPosition = 0
        self.degree = 0
    }
}
