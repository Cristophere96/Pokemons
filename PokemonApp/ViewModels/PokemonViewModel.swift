//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI
import Combine
import Resolver

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Injected var getPokemonFromAGenerationInteractor: GetPokemonsFromAGenerationInteractorType
    
    private var subscribers: Set<AnyCancellable> = []
    
    let limit: Int
    let offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    
    func fetchPokemons() {
        self.isLoading = true
        self.showError = false
        self.errorMessage = ""
        
        getPokemonFromAGenerationInteractor.getPokemonsFromAGeneration(limit: limit, offset: offset)?
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.pokemons = []
                    self?.isLoading = false
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] pokemons in
                withAnimation {
                    self?.isLoading = false
                    self?.pokemons = pokemons
                    self?.pokemons.sort { $0.id < $1.id }
                }
            }
            .store(in: &subscribers)
    }
}
