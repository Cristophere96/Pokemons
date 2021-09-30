//
//  PokemonsVotedViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI
import Combine
import Resolver

class PokemonsVotedViewModel: ObservableObject {
    private var pokemonsVoted: [DPokemonsVoted] = []
    
    @Published var pokemonsLiked = [Pokemon]()
    @Published var pokemondsDisliked = [Pokemon]()
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var selectedVoteType: Constants.VoteTypes = .LIKED
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Injected var networkInteractor: GetASinglePokemonInteractorType
    @Injected var pokemonsStoredInteractor: GetPokemonsVotedInteractorType
    
    init() {
        getAllPokemonsVoted()
        fetchPokemons()
    }
    
    func getAllPokemonsVoted() {
        pokemonsStoredInteractor.getAllPokemonsFromCoreData()?
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { pokemonsStored in
                withAnimation {
                    self.pokemonsVoted = pokemonsStored
                }
            })
            .store(in: &subscribers)
    }
    
    func fetchPokemons() {
        self.showError = false
        self.errorMessage = ""
        if pokemonsVoted.isEmpty {
            self.isEmpty = true
        } else {
            self.isEmpty = false
            self.isLoading = true
            
            for pokemonVoted in pokemonsVoted {
                networkInteractor.getASinglePokemon(url: pokemonVoted.url ?? "")
                    .sink { [weak self] completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self?.isLoading = false
                            self?.showError = true
                            self?.errorMessage = error.localizedDescription
                            self?.pokemonsLiked = []
                            self?.pokemondsDisliked = []
                        }
                    } receiveValue: { [weak self] pokemon in
                        self?.populatePokemonArray(type: pokemonVoted.voteType ?? "", pokemon: pokemon)
                    }
                    .store(in: &subscribers)
            }
            self.isLoading = false
        }
    }
    
    func populatePokemonArray(type: String, pokemon: Pokemon) {
        if type == "LIKED" {
            var exist: Bool = false
            for _pokemon in self.pokemonsLiked {
                if pokemon.id == _pokemon.id {
                    exist = true
                }
            }
            if !exist {
                withAnimation {
                    self.pokemonsLiked.append(pokemon)
                    self.pokemonsLiked.sort { $0.id < $1.id }
                    self.isLoading = false
                }
            }
        } else {
            var exist: Bool = false
            for _pokemon in self.pokemondsDisliked {
                if pokemon.id == _pokemon.id {
                    exist = true
                }
            }
            if !exist {
                withAnimation {
                    self.pokemondsDisliked.append(pokemon)
                    self.pokemondsDisliked.sort { $0.id < $1.id }
                    self.isLoading = false
                }
            }
        }
    }
}
