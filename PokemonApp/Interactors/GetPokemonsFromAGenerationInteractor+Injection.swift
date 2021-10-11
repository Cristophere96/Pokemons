//
//  GetPokemonsFromAGeneration+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import SwiftUI
import Resolver

extension Resolver {
    public static func registerGetPokemonsFromAGeneration() {
        register(GetPokemonsFromAGenerationInteractorType.self) { _ in
            return GetPokemonsFromAGenerationInteractor()
        }
        register(PokemonRepositoryType.self) { _ in
            return APIPokemonRepository()
        }
    }
}
