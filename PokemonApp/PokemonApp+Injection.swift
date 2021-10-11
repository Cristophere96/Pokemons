//
//  PokemonApp+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerGetPokemonsFromAGeneration()
        registerGetASinglePokemon()
        registerGetRandomPokemon()
        registerGetPokemondsVoted()
        registerStorePokemon()
        registerAPIPokemonRepository()
        registerCoreDataPokemonRepository()
    }
}

