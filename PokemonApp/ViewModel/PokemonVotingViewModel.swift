//
//  PokemonVotingViewModel.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI

class PokemonVotingViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.viewContext
    
    @Published var pokemon = [Pokemon]()
    @Published var isLoading: Bool = false
    var baseUrl: String = ""
    
    init() {
        fetchSinglePokemon()
    }
    
    func generateRandomPokemonURL() {
        let number = Int.random(in: 1..<894)
        
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
    
    func saveToCoreData(type: String) {
        let new = PokemonsVoted(context: self.viewContext)
        new.url = self.baseUrl
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
                if item.url == self.baseUrl {
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
