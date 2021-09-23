//
//  CoreDataPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI

class CoreDataPokemonRepository: PokemonDataBaseRepositoryType {
    func getAllPokemonsFromCoreData(completion: @escaping (Result<[PokemonsVoted], Error>) -> Void) {
        let data = PersistenceController.shared.getAllPokemonsVoted()
        completion(.success(data))
    }
    
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let viewContext = PersistenceController.shared.viewContext
        let new = PokemonsVoted(context: viewContext)
        new.url = url
        new.voteType = type
    }
}
