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
    let backgroundColor: Color
    var pokemonTypeTextSize: Font
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.backgroundColor = Color(Utils.backgroundColor(forType: pokemon.types[0].type.name))
        self.pokemonTypeTextSize = UIScreen.main.bounds.width <= 320.0 ? .caption2 : UIScreen.main.bounds.width < 390 ? .caption : .subheadline
    }
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: PokemonDetail(pokemon: pokemon),
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
                                    .font(pokemonTypeTextSize)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.25))
                                    )
                                    .frame(width: UIScreen.main.bounds.width * 0.210, height: 24)
                                
                                KFImage(URL(string: pokemon.sprites.front_default))
                                    .frame(width: UIScreen.main.bounds.width * 0.22, height: UIScreen.main.bounds.width * 0.22)
                                    .padding(.bottom, 8)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .background(backgroundColor)
                    .cornerRadius(12)
                    .shadow(color: backgroundColor, radius: 3, x: 0.0, y: 0.0)
                })
        }
    }
}
