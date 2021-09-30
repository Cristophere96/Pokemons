//
//  GetPokemonsVotedInteractor+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import Resolver

extension Resolver {
    public static func registerGetPokemondsVoted() {
        register(GetPokemonsVotedInteractorType.self) { _ in
            return GetPokemonsVotedInteractor()
        }
        register(PokemonDataBaseRepositoryType.self) { _ in
            return CoreDataPokemonRepository()
        }
    }
}
