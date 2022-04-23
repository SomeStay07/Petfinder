//
//  CoreDataTests.swift
//  PetfinderTests
//
//  Created by Timur Cheberda on 23.04.2022.
//

import XCTest
@testable import Petfinder
import CoreData

class CoreDataTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testToManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext
        let fetchRequest = AnimalEntity.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \AnimalEntity.name, ascending: true)]
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first
        else {
            return
        }
        
        XCTAssert(first.name == "CHARLA", """
        Pet name did not match, was expecting Kiki, got
        \(String(describing: first.name))
      """)
        
        XCTAssert(first.type == "Dog", """
        Pet type did not match, was expecting Cat, got
        \(String(describing: first.type))
      """)
        
        XCTAssert(first.coat.rawValue == "Short", """
        Pet coat did not match, was expecting Short, got
        \(first.coat.rawValue)
      """)
    }
    
    func testDeleteManagedObject() throws {
        let previewContext =
        PersistenceController.preview.container.viewContext
        
        let fetchRequest = AnimalEntity.fetchRequest()
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first
        else {
            return
        }
        
        previewContext.delete(first)
        
        guard let results = try? previewContext.fetch(fetchRequest) else {
            return
        }
        
        XCTAssert(results.count == 9, """
      The number of results was expected to be 9 after deletion, was \(results.count)
    """)
    }
    
    func testFetchManagedObject() throws {
        let previewContext = PersistenceController.preview.container.viewContext
        let fetchRequest = AnimalEntity.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Ellie")
        
        guard let results = try? previewContext.fetch(fetchRequest),
              let first = results.first
        else {
            return
        }
        
        XCTAssert(first.name == "Ellie", """
      Pet name did not match, expecting Ellie, got
      \(String(describing: first.name))
    """)
    }
    
}
