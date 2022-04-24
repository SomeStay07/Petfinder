//
//  SearchViewModelTestCase.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import Foundation
import XCTest
@testable import Petfinder

final class SearchViewModelTestCase: XCTestCase {
    
    let testContext = PersistenceController.preview.container.viewContext
    
    var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = SearchViewModel(
            animalSearcher: AnimalSearcherMock(),
            animalStore: AnimalStoreService(context: testContext)
        )
    }
    
    func testShouldFilterIsFalseForEmptyFilters() {
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertFalse(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForSearchText() {
        viewModel.searchText = "Kiki"
        
        XCTAssertFalse(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForAgeFilter() {
        viewModel.ageSelection = .baby
        
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .baby)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testShouldFilterIsTrueForTypeFilter() {
        viewModel.typeSelection = .cat
        
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .cat)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testClearFiltersSearchTextIsNotEmpty() {
        viewModel.typeSelection = .cat
        viewModel.ageSelection = .baby
        viewModel.searchText = "Kiki"
        
        viewModel.clearFilters()
        
        XCTAssertFalse(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
    func testClearFiltersSearchTextIsEmpty() {
        viewModel.typeSelection = .cat
        viewModel.ageSelection = .baby
        
        viewModel.clearFilters()
        
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .none)
        XCTAssertFalse(viewModel.shouldFilter)
    }
    
    func testSelectTypeSuggestion() {
        viewModel.selectTypeSuggestion(.cat)
        
        XCTAssertTrue(viewModel.searchText.isEmpty)
        XCTAssertEqual(viewModel.ageSelection, .none)
        XCTAssertEqual(viewModel.typeSelection, .cat)
        XCTAssertTrue(viewModel.shouldFilter)
    }
    
}
