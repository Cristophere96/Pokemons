//
//  GenerationsView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 27/06/21.
//

import SwiftUI

struct GenerationsView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16 ) {
                        GenerationCell(title: "Generation 1", image: "first_gen", limit: 151, offset: 0)
                        
                        GenerationCell(title: "Generation 2", image: "second_gen", limit: 100, offset: 151)
                        
                        GenerationCell(title: "Generation 3", image: "third_gen", limit: 135, offset: 251)
                        
                        GenerationCell(title: "Generation 4", image: "fourth_gen", limit: 107, offset: 386)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .navigationTitle("Pokedex")
                }
            }
        }
    }
}

struct GenerationsView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationsView()
            .preferredColorScheme(.dark)
    }
}
