//
//  Resolver+Test.swift
//  PokemonAppTests
//
//  Created by Cristopher Escorcia on 1/10/21.
//

import Resolver
@testable import PokemonApp

extension Resolver {
    static var mock = Resolver(parent: .main)
    
    static func registerMockService() {
        root = Resolver.mock
        defaultScope = .application
        Resolver.mock.register { GetRandomPokemonInteractorStub() }.implements(GetRandomPokemonInteractorType.self)
        Resolver.mock.register { GetPokemonsFromAGenerationInteractorStub() }.implements(GetPokemonsFromAGenerationInteractorType.self)
    }
}
