//
//  PokemonVotingView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 28/06/21.
//

import SwiftUI
import Kingfisher

struct PokemonVotingView: View {
    @ObservedObject var viewModel = PokemonVotingViewModel()
    
    var body: some View {
        VStack {
            if viewModel.showError {
                ErrorView(buttonAction: { viewModel.fetchRandomPokemon() }, errorMessage: viewModel.errorMessage)
            }
            if viewModel.isLoading {
                LoadingView()
            } else {
                ForEach(viewModel.pokemon) { pokemon in
                    ZStack {
                        VStack(alignment: .center) {
                            KFImage(URL(string: pokemon.sprites.front_default))
                                .resizable()
                                .frame(width: 300, height: 300)
                                .padding([.vertical, .horizontal], 20)
                            
                            Text(pokemon.name.capitalized)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 20)
                                .padding(.leading)
                            
                            HStack {
                                ForEach(pokemon.types, id: \.slot) { type in
                                    Text(type.type.name.capitalized)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .frame(width: 150, height: 40)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .background(Color(Utils.backgroundColor(forType: pokemon.types[0].type.name)))
                    .cornerRadius(12)
                    .shadow(color: Color(Utils.backgroundColor(forType: pokemon.types[0].type.name)), radius: 6, x: 0.0, y: 0.0)
                    
                    HStack(alignment: .center, spacing: 80) {
                        Button(action: {
                            viewModel.dislikePokemon()
                        }) {
                            Image(systemName: "heart.slash.fill")
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                                .background(Color(UIColor.systemBackground))
                                .clipShape(Circle())
                                .shadow(color: Color(.systemGray), radius: 6, x: 0.0, y: 0.0)
                        }
                        
                        Button(action: {
                            viewModel.likePokemon()
                        }) {
                            Image(systemName: "heart.fill")
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                                .background(Color(UIColor.systemBackground))
                                .clipShape(Circle())
                                .shadow(color: Color(.systemGray), radius: 6, x: 0.0, y: 0.0)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 10)
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
