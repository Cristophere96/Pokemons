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
            VStack {
                Picker("choose the type", selection: $viewModel.selectedVoteType) {
                    ForEach(Constants.VoteTypes.allCases, id: \.self) {
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: Constants.gridItems, spacing: 16 ) {
                            ForEach(viewModel.selectedVoteType == .LIKED ? viewModel.pokemonsLiked : viewModel.pokemondsDisliked, id: \.id) { pokemon in
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
                    if viewModel.isEmpty {
                        Text("You haven't voted for any Pokemon")
                            .font(.title3)
                    }
                    if viewModel.showError {
                        ErrorView(buttonAction: {
                            viewModel.getAllPokemonsVoted()
                            viewModel.fetchPokemons()
                        }, errorMessage: viewModel.errorMessage)
                    }
                }
            }
            .onAppear(){
                viewModel.getAllPokemonsVoted()
                viewModel.fetchPokemons()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PokemonsVotedView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonsVotedView()
    }
}
