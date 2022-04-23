//
//  AnimalEnvironment+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension AnimalEnvironment: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<AnimalEnvironment>: String] {
        [
            \.children: "children",
             \.dogs: "dogs",
             \.cats: "cats",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = AnimalEnvironmentEntity
    
}
