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
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private var subscribers: Set<AnyCancellable> = []
    
    let limit: Int
    let offset: Int
    let interactor: GetPokemonsFromAGenerationInteractor
    
    init(limit: Int,
         offset: Int,
         interactor: GetPokemonsFromAGenerationInteractor = GetPokemonsFromAGenerationInteractor(repository: APIPokemonRepository(urlSession: URLSession.shared))
    ) {
        self.limit = limit
        self.offset = offset
        self.interactor = interactor
        fetchPokemons()
    }
    
    func fetchPokemons() {
        self.isLoading = true
        self.showError = false
        self.errorMessage = ""
        
        interactor.getPokemonsURLFromAGeneration(limit: limit, offset: offset)?
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
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
