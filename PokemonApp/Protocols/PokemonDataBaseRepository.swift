//
//  PokemonDataBaseRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI
import Combine

protocol PokemonDataBaseRepositoryType {
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>?
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>?
}
