//
//  PokemonsView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI

struct PokemonsView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel: PokemonViewModel
    let limit: Int
    let offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        self.viewModel = PokemonViewModel(limit: limit, offset: offset)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16 ) {
                    ForEach(viewModel.pokemons) { pokemon in
                        PokemonCell(pokemon: pokemon, viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .navigationTitle("Pokedex")
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct PokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonsView(limit: 151, offset: 0)
    }
}
