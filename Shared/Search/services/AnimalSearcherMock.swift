//
//  AnimalSearcherMock.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

struct AnimalSearcherMock: AnimalSearcher {
    
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal] {
        var animals = Animal.mock
        
        if age != .none {
            animals = animals.filter {
                $0.age.rawValue.lowercased() == age.rawValue.lowercased()
            }
        }
        
        if type != .none {
            animals = animals.filter {
                $0.type.lowercased() == type.rawValue.lowercased()
            }
        }
        
        return animals.filter {
            $0.name.contains(text)
        }
    }
    
}
