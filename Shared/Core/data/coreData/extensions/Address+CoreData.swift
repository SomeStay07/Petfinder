//
//  Address+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension Address: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<Address>: String] {
        [
            \.address1: "address1",
             \.address2: "address2",
             \.city: "city",
             \.state: "state",
             \.postcode: "postcode",
             \.country: "country",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = AddressEntity
    
}
