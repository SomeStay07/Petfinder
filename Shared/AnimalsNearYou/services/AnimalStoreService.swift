//
//  AnimalStoreService.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import CoreData

struct AnimalStoreService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

extension AnimalStoreService: AnimalStore {
    
    func save(animals: [Animal]) async throws {
        for var animal in animals {
            animal.toManagedObject(context: context)
        }
        
        try context.save()
    }
    
}
