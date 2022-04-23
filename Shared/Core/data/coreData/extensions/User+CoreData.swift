//
//  User+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension User: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<User>: String] {
        [
            \.name: "name",
             \.password: "password",
             \.extra: "extra",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = UserEntity
    
}
