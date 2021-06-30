//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI
import Kingfisher

struct PokemonVotedCell: View {
    let pokemon: Pokemon
    let viewModel: PokemonsVotedViewModel
    let backgroundColor: Color
    
    init(pokemon: Pokemon, viewModel: PokemonsVotedViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
        self.backgroundColor = Color(viewModel.backgroundColor(forType: pokemon.types[0].type.name))
    }
    
    var body: some View {
        ZStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.leading)
                    
                    HStack {
                        Text(pokemon.types[0].type.name.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.25))
                            )
                            .frame(width: 100, height: 24)
                        
                        KFImage(URL(string: pokemon.sprites.front_default))
                            .frame(width: 68, height: 68)
                            .padding([.bottom, .trailing], 4)
                    }
                }
            }
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(color: backgroundColor, radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            
        }
    }
}

