//
//  CoreDataPokemonRepository+Injection.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import SwiftUI
import Resolver

extension Resolver {
    public static func registerCoreDataPokemonRepository() {
        register(CoreDataServiceType.self) { _ in
            return CoreDataService()
        }
    }
}
