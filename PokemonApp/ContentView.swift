//
//  ContentView.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 25/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GenerationsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Generations")
                }
            
            PokemonVotingView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Vote for a Pokemon")
                }
            
            PokemonsVotedView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Your votes")
                }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
