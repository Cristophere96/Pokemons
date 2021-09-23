//
//  PokemonDetail.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 26/06/21.
//

import SwiftUI
import Kingfisher

struct PokemonDetail: View {
    let pokemon: Pokemon
    let color: Color
    let pokemonWeight: String
    let pokemonHeight: String
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.color = Color(Utils.backgroundColor(forType: pokemon.types[0].type.name))
        self.pokemonWeight = Utils.parseWeigthAndHeigth(forValue: pokemon.weight)
        self.pokemonHeight = Utils.parseWeigthAndHeigth(forValue: pokemon.height)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: pokemon.sprites.front_default))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding([.bottom, .trailing], 4)
                
                VStack (alignment: .leading, spacing: 20) {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(color)
                    Text("#\(pokemon.id) in pokedex")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(color)
                    
                    Text("Types")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(pokemon.types, id: \.slot) { type in
                                Text(type.type.name.capitalized)
                                    .font(.subheadline)
                                    .foregroundColor(Color(.label))
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 24)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                Color(
                                                    Utils.backgroundColor(forType: type.type.name)
                                                ).opacity(0.25))
                                    )                            }
                        }
                    }
                    
                    Text("More Info about " + pokemon.name.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    HStack {
                        Text("Weigth: \(pokemonWeight) kg")
                            .font(.headline)
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        Text("Heigth: \(pokemonHeight) m")
                            .font(.headline)
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    
                    Text("List of moves")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(pokemon.moves.prefix(5), id: \.move.name) { move in
                                Text(move.move.name)
                                    .font(.subheadline)
                                    .foregroundColor(Color(.label))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)                                    
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640, alignment: .center)
            }
        }
    }
}
