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
    let viewModel: PokemonViewModel
    let color: Color
    let pokemonWeight: String
    let pokemonHeight: String
    
    init(pokemon: Pokemon, viewModel: PokemonViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
        self.color = Color(viewModel.backgroundColor(forType: pokemon.types[0].type.name))
        self.pokemonWeight = viewModel.parseWeigthAndHeigth(forValue: pokemon.weight)
        self.pokemonHeight = viewModel.parseWeigthAndHeigth(forValue: pokemon.height)
    }
    
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: pokemon.sprites.front_default))
                    .frame(width: 68, height: 68)
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
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(
                                                Color(
                                                    viewModel.backgroundColor(forType: type.type.name)
                                                ).opacity(0.25))
                                    )
                                    .frame(width: 100, height: 24)
                            }
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
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(
                                                Color(.label).opacity(0.25))
                                    )
                                    
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: 640, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}
