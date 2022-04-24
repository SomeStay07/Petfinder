//
//  SearchViewModel.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

protocol AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal]
}

final class SearchViewModel: ObservableObject {
    
    @Published var ageSelection = AnimalSearchAge.none
    @Published var typeSelection = AnimalSearchType.none
    @Published var searchText = ""
    
    private let animalSearcher: AnimalSearcher
    private let animalStore: AnimalStore
    
    var shouldFilter: Bool {
        !searchText.isEmpty ||
        ageSelection != .none ||
        typeSelection != .none
    }
    
    init(animalSearcher: AnimalSearcher, animalStore: AnimalStore) {
        self.animalSearcher = animalSearcher
        self.animalStore = animalStore
    }
    
    func search() {
        Task {
            let animals = await animalSearcher.searchAnimal(
                by: searchText,
                age: ageSelection,
                type: typeSelection
            )
            
            do {
                try await animalStore.save(animals: animals)
            } catch {
                print("Error storing animals... \(error.localizedDescription)")
            }
        }
    }
    
    func clearFilters() {
        typeSelection = .none
        ageSelection = .none
    }
    
    func selectTypeSuggestion(_ type: AnimalSearchType) {
        typeSelection = type
        search()
    }
    
}
