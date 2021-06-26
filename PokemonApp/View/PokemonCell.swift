//
//  PokemonCell.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI
import Kingfisher

struct PokemonCell: View {
    let pokemon: Pokemon
    let viewModel: PokemonViewModel
    let backgroundColor: Color
    
    init(pokemon: Pokemon, viewModel: PokemonViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
        self.backgroundColor = Color(viewModel.backgroundColor(forType: pokemon.types[0].type.name))
    }
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: PokemonDetail(pokemon: pokemon, viewModel: viewModel),
                label: {
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
                                
                                KFImage(URL(string: pokemon.sprites.url))
                                    .frame(width: 68, height: 68)
                                    .padding([.bottom, .trailing], 4)
                            }
                        }
                    }
                    .background(backgroundColor)
                    .cornerRadius(12)
                    .shadow(color: backgroundColor, radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                })
        }
    }
}
