//
//  PokemonDataBaseRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI

protocol PokemonDataBaseRepositoryType {
    func getAllPokemonsFromCoreData(completion: @escaping (Result<[PokemonsVoted], Error>) -> Void)
    
    func savePokemonToCoreData(url: String, type: String, completion: @escaping (Result<Void, Error>) -> Void)
}
