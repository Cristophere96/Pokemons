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
            PokemonsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List of Pokemons")
                }
            Text("This are your favorites Pokemons")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
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
