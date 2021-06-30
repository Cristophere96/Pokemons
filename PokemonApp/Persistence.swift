//
//  Persistence.swift
//  PokemonApp
//
//  Created by Cristopher Escorcia on 29/06/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func getAllPokemonsVoted() -> [PokemonsVoted] {
        let request: NSFetchRequest<PokemonsVoted> = PokemonsVoted.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    private init() {
        container = NSPersistentContainer(name: "PokemonsVoted")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
