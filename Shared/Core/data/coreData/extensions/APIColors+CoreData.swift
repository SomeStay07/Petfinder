//
//  APIColors+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension APIColors: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<APIColors>: String] {
        [
            \.primary: "primary",
             \.secondary: "secondary",
             \.tertiary: "tertiary"
        ]
    }
    
    typealias ManagedType = APIColorsEntity
    
}
