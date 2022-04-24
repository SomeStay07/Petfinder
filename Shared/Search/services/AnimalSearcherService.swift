//
//  AnimalSearcherService.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

struct AnimalSearcherService {
    let requestManager: RequestManagerProtocol
}

extension AnimalSearcherService: AnimalSearcher {
    
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsBy(
            name: text,
            age: age == .none ? nil : age.rawValue,
            type: type == .none ? nil : type.rawValue
        )
        
        do {
            let animalsContainer: AnimalsContainer = try await requestManager.perform(requestData)
            return animalsContainer.animals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
