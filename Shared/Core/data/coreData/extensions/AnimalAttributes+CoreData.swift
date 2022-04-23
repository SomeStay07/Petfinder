//
//  AnimalAttributes+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension AnimalAttributes: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<AnimalAttributes>: String] {
        [
            \.spayedNeutered: "spayedNeutered",
             \.houseTrained: "houseTrained",
             \.declawed: "declawed",
             \.specialNeeds: "specialNeeds",
             \.shotsCurrent: "shotsCurrent",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = AnimalAttributesEntity
    
}
