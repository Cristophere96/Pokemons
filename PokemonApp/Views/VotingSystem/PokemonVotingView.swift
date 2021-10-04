//
//  PokemonVotingView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI

struct PokemonVotingView: View {
    @ObservedObject var viewModel = PokemonVotingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showError {
                    ErrorView(buttonAction: { viewModel.fetchRandomPokemon() }, errorMessage: viewModel.errorMessage)
                }
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    Text("Swipe the pokemon card to the left if you dislike it or right if you like it")
                        .font(.body)
                        .fontWeight(.light)
                        .offset(y: -80)
                    
                    ForEach(viewModel.pokemon) { pokemon in
                        
                        LargePokemonCell(pokemon: pokemon,
                                         xPosition: $viewModel.xPosition,
                                         likePokemon: viewModel.likePokemon,
                                         dislikePokemon: viewModel.dislikePokemon)
                            .offset(y: -60)
                    }
                }
            }
        }
    }
}

struct PokemonVotingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonVotingView()
        }
    }
}
