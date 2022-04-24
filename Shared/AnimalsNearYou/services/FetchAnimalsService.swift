//
//  FetchAnimalsService.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import Foundation

actor FetchAnimalsService {
    
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
}

// MARK: - AnimalFetcher
extension FetchAnimalsService: AnimalsFetcher {
    
    func fetchAnimals(
        page: Int,
        latitude: Double?,
        longitude: Double?
    ) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsWith(
            page: page,
            latitude: latitude,
            longitude: longitude
        )
        do {
            let animalsContainer: AnimalsContainer = try await
            requestManager.perform(requestData)
            return animalsContainer.animals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
