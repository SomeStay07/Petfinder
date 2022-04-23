//
//  PhotoSizes+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension PhotoSizes: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<PhotoSizes>: String] {
        [
            \.small: "small",
             \.medium: "medium",
             \.large: "large",
             \.full: "full",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = PhotoSizesEntity
    
}
