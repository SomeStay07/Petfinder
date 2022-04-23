//
//  AnimalAttributes.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

struct AnimalAttributes: Codable {
    var id: Int?
    var spayedNeutered: Bool? = false
    var houseTrained: Bool? = false
    var declawed: Bool? = false
    var specialNeeds: Bool? = false
    var shotsCurrent: Bool? = false
}
