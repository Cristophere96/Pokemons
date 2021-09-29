//
//  StorePokemonInteractor.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/09/21.
//

import SwiftUI
import Combine

class StorePokemonInteractor {
    private var repository: PokemonDataBaseRepositoryType
    
    init(repo: PokemonDataBaseRepositoryType) {
        self.repository = repo
    }
    
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.repository.savePokemonToCoreData(url: url, type: type, completion: completion)
    }
}
