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
                    VStack(spacing: 20) {
                        VStack {
                            Text("To vote, swipe left ← if you dislike the pokemon or right → if you like it")
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding()
                        }
                        .frame(height: 75)
                        .background(Color("background").opacity(0.08))
                        .cornerRadius(8)
                        
                        ForEach(viewModel.pokemon) { pokemon in
                            ZStack {
                                LargePokemonCell(pokemon: pokemon,
                                                 xPosition: $viewModel.xPosition,
                                                 degree: $viewModel.degree,
                                                 likePokemon: viewModel.likePokemon,
                                                 dislikePokemon: viewModel.dislikePokemon)
                                
                                if viewModel.showAnimation {
                                    VStack {
                                        LottieView(fileName: viewModel.animationName)
                                            .frame(width: 200, height: 200)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
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
