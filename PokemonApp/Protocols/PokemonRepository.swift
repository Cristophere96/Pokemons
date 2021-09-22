//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 21/09/21.
//

import SwiftUI

protocol PokemonRepositoryType {
    func getAllPokemonsFromAGeneration(limit: Int, offset: Int,
                                       completion: @escaping (Result<[Pokemon], Error>) ->  Void)
    
    func getASinglePokemon(url: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
}
