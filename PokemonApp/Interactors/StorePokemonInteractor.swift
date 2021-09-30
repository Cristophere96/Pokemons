//
//  StorePokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import SwiftUI
import Combine
import Resolver

protocol StorePokemonInteractorType {
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class StorePokemonInteractor: StorePokemonInteractorType {
    @Injected var repository: PokemonDataBaseRepositoryType
    
    init() {  }
    
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.repository.savePokemonToCoreData(url: url, type: type, completion: completion)
    }
}
