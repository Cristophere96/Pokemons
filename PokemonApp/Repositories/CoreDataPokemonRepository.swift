//
//  CoreDataPokemonRepository.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 22/09/21.
//

import SwiftUI
import Combine

class CoreDataPokemonRepository: PokemonDataBaseRepositoryType {
    private let viewContext = PersistenceController.shared.viewContext
    
    func getAllPokemonsFromCoreData() -> AnyPublisher<[DPokemonsVoted], Error>? {
        return CoreDataManagerPublisher(request: PokemonsVoted.fetchRequest(), context: viewContext)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { $0.map{ DPokemonsVoted(id: $0.id, url: $0.url, voteType: $0.voteType) } }
            .eraseToAnyPublisher()
    }
    
    func savePokemonToCoreData(url: String, type: String) -> AnyPublisher<Bool, Error>? {
        var publisher = CurrentValueSubject<Bool, Error>(false)
        
        let viewContext = PersistenceController.shared.viewContext
        let new = PokemonsVoted(context: viewContext)
        new.id = UUID()
        new.url = url
        new.voteType = type
        
        do {
            try viewContext.save()
            publisher = CurrentValueSubject<Bool, Error>(true)
        } catch {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
