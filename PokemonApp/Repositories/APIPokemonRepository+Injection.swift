//
//  APIPokemonRepository+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import SwiftUI
import Resolver

extension Resolver {
    public static func registerAPIPokemonRepository() {
        register(PokemonServiceType.self) { _ in
            return PokemonService()
        }
    }
}
