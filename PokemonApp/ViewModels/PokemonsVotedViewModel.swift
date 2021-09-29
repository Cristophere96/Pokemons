//
//  PokemonsVotedViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI
import Combine

class PokemonsVotedViewModel: ObservableObject {
    private var pokemonsVoted: [DPokemonsVoted] = []
    
    @Published var pokemons = [Pokemon]()
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private var subscribers: Set<AnyCancellable> = []
    
    let networkInteractor: GetASinglePokemonInteractor
    let pokemonsStoredInteractor: GetPokemonsVotedInteractor
    
    init(networkInteractor: GetASinglePokemonInteractor = GetASinglePokemonInteractor(repository: APIPokemonRepository(urlSession: URLSession.shared)),
         pokemonsStoredInteractor: GetPokemonsVotedInteractor = GetPokemonsVotedInteractor(repository: CoreDataPokemonRepository())
    ) {
        self.networkInteractor = networkInteractor
        self.pokemonsStoredInteractor = pokemonsStoredInteractor
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
                            self?.pokemons = []
                        }
                    } receiveValue: { [weak self] pokemon in
                        var exist: Bool = false
                        for _pokemon in self?.pokemons ?? [] {
                            if pokemon.id == _pokemon.id {
                                exist = true
                            }
                        }
                        if !exist {
                            withAnimation {
                                self?.pokemons.append(pokemon)
                                self?.pokemons.sort { $0.id < $1.id }
                                self?.isLoading = false
                            }
                        }
                    }
                    .store(in: &subscribers)
            }
            self.isLoading = false
        }
    }
}
