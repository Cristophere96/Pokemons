//
//  GetASinglePokemonInteractor+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import SwiftUI
import Resolver

extension Resolver {
    public static func registerGetASinglePokemon() {
        register(GetASinglePokemonInteractorType.self) { _ in
            return GetASinglePokemonInteractor()
        }
        register(PokemonRepositoryType.self) { _ in
            return APIPokemonRepository(urlSession: URLSession.shared)
        }
    }
}
