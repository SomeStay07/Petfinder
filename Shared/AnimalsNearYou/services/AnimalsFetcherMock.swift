//
//  AnimalsFetcherMock.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

struct AnimalsFetcherMock: AnimalsFetcher {
    
    func fetchAnimals(
        page: Int,
        latitude: Double?,
        longitude: Double?
    ) async -> [Animal] {
        return Animal.mock
    }
    
}
