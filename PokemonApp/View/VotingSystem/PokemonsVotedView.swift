//
//  PokemonsVotedView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import SwiftUI

struct PokemonsVotedView: View {
    @ObservedObject var viewModel = PokemonsVotedViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: Constants.gridItems, spacing: 16 ) {
                        ForEach(viewModel.pokemons, id: \.id) { pokemon in
                            PokemonCell(pokemon: pokemon)
                        }
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .navigationTitle("Pokemons you voted")
                }
                if viewModel.isLoading {
                    LoadingView()
                }
                if viewModel.pokemons.isEmpty {
                    Text("You haven't voted for any Pokemon")
                        .font(.title3)
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
