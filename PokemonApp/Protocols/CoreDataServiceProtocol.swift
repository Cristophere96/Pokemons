//
//  CoreDataServiceProtocol.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 6/10/21.
//

import SwiftUI
import Combine

protocol CoreDataServiceType {
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>?
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>?
}
