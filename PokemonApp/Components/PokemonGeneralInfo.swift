//
//  PokemonGeneralInfo.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 7/10/21.
//

import SwiftUI

struct PokemonGeneralInfo: View {
    var pokemon: Pokemon
    let pokemonWeight: String
    let pokemonHeight: String

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.pokemonWeight = Utils.parseWeigthAndHeigth(forValue: pokemon.weight)
        self.pokemonHeight = Utils.parseWeigthAndHeigth(forValue: pokemon.height)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ForEach(pokemon.types, id: \.slot) { type in
                    Text(type.type.name.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .foregroundColor(Color("background"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                        .background(
                            Color(Utils.backgroundColor(forType: type.type.name))
                        )
                        .cornerRadius(10)
                }
            }
            
            HStack {
                Text("Weigth: \(pokemonWeight) kg")
                    .font(.headline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                
                Text("Heigth: \(pokemonHeight) m")
                    .font(.headline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
        }
    }
}
