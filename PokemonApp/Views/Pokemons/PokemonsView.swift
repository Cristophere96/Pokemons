//
//  PokemonsView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI

struct PokemonsView: View {
    @ObservedObject var viewModel: PokemonViewModel
    let limit: Int
    let offset: Int
    let title: String
    
    init(limit: Int, offset: Int, title: String) {
        self.limit = limit
        self.offset = offset
        self.title = title
        self.viewModel = PokemonViewModel(limit: limit, offset: offset)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: Constants.gridItems, spacing: 16 ) {
                    ForEach(viewModel.pokemons) { pokemon in
                        PokemonCell(pokemon: pokemon)
                    }
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .navigationTitle(title)
            }
            if viewModel.isLoading {
                LoadingView()
            }
            if viewModel.showError {
                ErrorView(buttonAction: { viewModel.fetchPokemons() },
                          errorMessage: viewModel.errorMessage)
            }
        }
    }
}

struct PokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonsView(limit: 151, offset: 0, title: "Generation 1")
    }
}
