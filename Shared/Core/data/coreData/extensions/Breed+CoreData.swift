//
//  Breed+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

// MARK: - CoreDataPersistable

extension Breed: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<Breed>: String] {
        [
            \.primary: "primary",
             \.secondary: "secondary",
             \.mixed: "mixed",
             \.unknown: "unknown",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = BreedEntity
    
}
