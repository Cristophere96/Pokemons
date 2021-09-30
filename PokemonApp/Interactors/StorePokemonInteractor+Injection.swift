//
//  StorePokemonInteractor+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import Resolver

extension Resolver {
    public static func registerStorePokemon() {
        register(StorePokemonInteractorType.self) { _ in
            return StorePokemonInteractor()
        }
        register(PokemonDataBaseRepositoryType.self) { _ in
            return CoreDataPokemonRepository()
        }
    }
}
