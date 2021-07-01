//
//  PokemonsVotedView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI

struct PokemonsVotedView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var viewModel = PokemonsVotedViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16 ) {
                        ForEach(viewModel.pokemons, id: \.id) { pokemon in
                            PokemonVotedCell(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .navigationTitle("Pokemons you voted")
                }
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
        .onAppear(){
            viewModel.getAllPokemonsVoted()
            viewModel.fetchPokemons()
        }
    }
}

struct PokemonsVotedView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonsVotedView()
    }
}
