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
        Resolver.mock.register { GetASinglePokemonInteractorStub() }.implements(GetASinglePokemonInteractorType.self)
        Resolver.mock.register { GetPokemonsVotedInteractorStub() }.implements(GetPokemonsVotedInteractorType.self)
        Resolver.mock.register { StorePokemonInteractorStub() }.implements(StorePokemonInteractorType.self)
        Resolver.mock.register { APIPokemonRepositoryStub() }.implements(PokemonRepositoryType.self)
        Resolver.mock.register { CoreDataPokemonRepositoryStub() }.implements(PokemonDataBaseRepositoryType.self)
        Resolver.mock.register { PokemonServiceStub() }.implements(PokemonServiceType.self)
        Resolver.mock.register { CoreDataServiceStub() }.implements(CoreDataServiceType.self)
    }
}
