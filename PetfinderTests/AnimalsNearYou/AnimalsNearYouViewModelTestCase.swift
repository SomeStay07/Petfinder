//
//  AnimalsNearYouViewModelTestCase.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import XCTest
@testable import Petfinder

@MainActor
final class AnimalsNearYouViewModelTestCase: XCTestCase {
    
    let testContext = PersistenceController.preview.container.viewContext

    var viewModel: AnimalsNearYouViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: AnimalsFetcherMock(),
            animalStore: AnimalStoreService(context: testContext)
        )
    }
    
    func testFetchAnimalsLoadingState() async {
        XCTAssertTrue(viewModel.isLoading, "The view model should be loading, but it isn't")
        
        await viewModel.fetchAnimals(location: nil)
        
        XCTAssertFalse(viewModel.isLoading, "The view model shouldn't be loading, but it is")
    }
    
    func testUpdatePageOnFetchMoreAnimals() async {
        XCTAssertEqual(
            viewModel.page,
            1,
            "the view model's page property should be 1 before fetching, but it's \(viewModel.page)"
        )
        
        await viewModel.fetchMoreAnimals(location: nil)
        
        XCTAssertEqual(
            viewModel.page,
            2,
            "the view model's page property should be 2 after fetching, but it's \(viewModel.page)"
        )
    }
    
    func testFetchAnimalsEmptyResponse() async {
        viewModel = AnimalsNearYouViewModel(
            isLoading: true,
            animalFetcher: EmptyResponseAnimalsFetcherMock(),
            animalStore: AnimalStoreService(context: testContext)
        )
        
        await viewModel.fetchAnimals(location: nil)
        
        XCTAssertFalse(
            viewModel.hasMoreAnimals,
            "hasMoreAnimals should be false with an empty response, but it's true"
        )
        
        XCTAssertFalse(
            viewModel.isLoading,
            "the view model shouldn't be loading after receiving an empty response, but it is"
        )
    }
}

struct EmptyResponseAnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(page: Int, latitude: Double?, longitude: Double?) async -> [Animal] {
        return []
    }
}
