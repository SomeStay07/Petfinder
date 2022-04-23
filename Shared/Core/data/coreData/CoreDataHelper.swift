//
//  CoreDataHelper.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

enum CoreDataHelper {
    
    static let context = PersistenceController.shared.container.viewContext
    static let previewContext = PersistenceController.preview.container.viewContext
    
    static func clearDatabase() {
        let entities = PersistenceController.shared.container.managedObjectModel.entities
        entities.compactMap(\.name).forEach(clearTable)
    }
    
    private static func clearTable(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            fatalError("\(#file), \(#function), \(error.localizedDescription)")
        }
    }
}

// MARK: - Deleting Data

extension Collection where Element == NSManagedObject, Index == Int {
    
    func delete(at indices: IndexSet, inViewContext viewContext: NSManagedObjectContext = CoreDataHelper.context) {
        indices.forEach { index in
            viewContext.delete(self[index])
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("""
        \(#file), \
        \(#function), \
        \(error.localizedDescription)
      """)
        }
    }
    
}

// MARK: - Xcode Previews Content

extension CoreDataHelper {
    
    static func getTestAnimal() -> Animal? {
        let fetchRequest = AnimalEntity.fetchRequest()
        if let results = try? previewContext.fetch(fetchRequest),
           let first = results.first {
            return Animal(managedObject: first)
        }
        return nil
    }
    
    static func getTestAnimals() -> [Animal]? {
        let fetchRequest = AnimalEntity.fetchRequest()
        
        if let results = try? previewContext.fetch(fetchRequest), !results.isEmpty {
            return results.map(Animal.init(managedObject:))
        }
        return nil
    }
    
    static func getTestAnimalEntity() -> AnimalEntity? {
        let fetchRequest = AnimalEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first else { return nil }
        return first
    }
    
    static func getTestAnimalEntities() -> [AnimalEntity]? {
        let fetchRequest = AnimalEntity.fetchRequest()
        guard let results = try? previewContext.fetch(fetchRequest),
              !results.isEmpty else { return nil }
        return results
    }
    
}
