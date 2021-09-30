//
//  GetRandomPokemonInteractor+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import SwiftUI
import Resolver

extension Resolver {
    public static func registerGetRandomPokemon() {
        register(GetRandomPokemonInteractorType.self) { _ in
            return GetRandomPokemonInteractor()
        }
        register(PokemonRepositoryType.self) { _ in
            return APIPokemonRepository(urlSession: URLSession.shared)
        }
    }
}
