//
//  Contact+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension Contact: CoreDataPersistable {
    
    init(managedObject: ContactEntity?) {
        guard let managedObject = managedObject else { return }
        
        self.id = Int(managedObject.id)
        self.email = managedObject.email
        self.phone = managedObject.phone
        self.address = Address(managedObject: managedObject.address)
    }
    
    var keyMap: [PartialKeyPath<Contact>: String] {
        [
            \.email: "email",
             \.phone: "phone",
             \.address: "address"
        ]
    }
    
    typealias ManagedType = ContactEntity
    
    mutating func toManagedObject(context: NSManagedObjectContext) -> ManagedType {
        let persistedValue = ContactEntity.init(context: context)
        persistedValue.email = self.email
        persistedValue.phone = self.phone
        if var address = self.address {
            persistedValue.address = address.toManagedObject(context: context)
        }
        return persistedValue
    }
    
}
