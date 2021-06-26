//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var isLoading: Bool = false
    let limit: Int
    let offset: Int
    let baseUrl: String
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        fetchPokemon()
    }
    
    func fetchPokemon() {
        self.isLoading = true
        
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let pokedex = try? JSONDecoder().decode(Pokedex.self, from: data) else { return }
            
            for pokemon in pokedex.results {
                guard let jsonURL = pokemon.url else { return }
                guard let newURL = URL(string: jsonURL) else { return }
                
                URLSession.shared.dataTask(with: newURL) { data, response, error in
                    guard let data = data else { return }
                    guard let result = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
                    
                    DispatchQueue.main.async {
                        self.pokemons.append(result)
                        self.pokemons.sort {
                            $0.id < $1.id
                        }
                        self.isLoading = false
                    }
                }.resume()
            }
        }.resume()
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
    
    func parseWeigthAndHeigth(forValue value: Int) -> Int {
        return value / 10
    }
}
