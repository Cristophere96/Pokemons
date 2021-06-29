//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI

class PokemonVotingViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    @Published var isLoading: Bool = false
    var baseUrl: String = ""
    
    init() {
        fetchSinglePokemon()
    }
    
    func generateRandomPokemonURL() {
        let number = Int.random(in: 1..<387)
        
        self.baseUrl = "https://pokeapi.co/api/v2/pokemon/\(number)"
    }
    
    func fetchSinglePokemon() {
        self.isLoading = true
        generateRandomPokemonURL()
        
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let result = try? JSONDecoder().decode(Pokemon.self, from: data) else { return }
            
            DispatchQueue.main.async {
                self.pokemon = [result]
                self.isLoading = false
            }
        }.resume()
    }
    
    func likePokemon() {
        fetchSinglePokemon()
    }
    
    func dislikePokemon() {
        fetchSinglePokemon()
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
