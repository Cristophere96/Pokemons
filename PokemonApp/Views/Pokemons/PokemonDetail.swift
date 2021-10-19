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
    @State var selected: Constants.DetailOptions = .GENERAL
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.color = Color(Utils.backgroundColor(forType: pokemon.types[0].type.name))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                PokemonLargeImage(imageURL: pokemon.sprites.other?.officialArtwork.frontDefault ?? pokemon.sprites.front_default)
                
                VStack (alignment: .leading, spacing: 20) {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(color)
                    Text("#\(pokemon.id) in pokedex")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(color)
                    
                    Picker("choose the type", selection: $selected) {
                        ForEach(Constants.DetailOptions.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    switch selected {
                    case .GENERAL:
                        PokemonGeneralInfo(pokemon: pokemon)
                    case .MOVES:
                        PokemonMoves(pokemon: pokemon)
                    case .STATS:
                        PokemonStats(stats: pokemon.stats)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
