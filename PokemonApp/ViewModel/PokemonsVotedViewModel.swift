//
//  PokemonsVotedViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI

class PokemonsVotedViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.viewContext
    
    private var pokemonsVoted: [PokemonsVoted] = []
    
    @Published var pokemons = [Pokemon]()
    @Published var isLoading: Bool = false
    @Published var empty: Bool = false
    
    init() {
        getAllPokemonsVoted()
        fetchPokemons()
    }
    
    func getAllPokemonsVoted () {
        pokemonsVoted = PersistenceController.shared.getAllPokemonsVoted()
    }
    
    func fetchPokemons() {
        if pokemonsVoted.count == 0 {
            self.empty = true
        } else {
            self.isLoading = true
            for pokemonVoted in pokemonsVoted {
                guard let jsonURL = pokemonVoted.url else { return }
                guard let newURL = URL(string: jsonURL) else { return }
                
                URLSession.shared.dataTask(with: newURL) { data, response, error in
                    guard let data = data else { return }
                    guard let result = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                    var exist: Bool = false
                    
                    for pokemon in self.pokemons {
                        if pokemon.id == result.id {
                            exist = true
                        }
                    }
                    
                    if !exist {
                        DispatchQueue.main.async {
                            self.pokemons.append(result)
                            self.pokemons.sort {
                                $0.id < $1.id
                            }
                        }
                    }
                }.resume()
            }
            self.isLoading = false
        }
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "grass" : return .systemGreen
        case "water" : return .systemBlue
        case "electric": return .systemYellow
        case "pshychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
}
