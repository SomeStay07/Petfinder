//
//  AnimalsMock.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

import Foundation

private struct AnimalsMock: Codable {
    let animals: [Animal]
}

private func loadAnimals() -> [Animal] {
    
    guard let url = Bundle.main.url(
        forResource: "AnimalsMock",
        withExtension: "json"
    ), let data = try? Data(contentsOf: url) else { return [] }
    let decoder = JSONDecoder()
    // 3
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let jsonMock = try? decoder.decode(AnimalsMock.self, from: data)
    return jsonMock?.animals ?? []
    
}

extension Animal {
    static let mock = loadAnimals()
}
