//
//  AnimalsContainer.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import Foundation

struct AnimalsContainer: Decodable {
    let animals: [Animal]
    let pagination: Pagination
}
