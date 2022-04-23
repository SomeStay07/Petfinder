//
//  AnimalsRequestMock.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import Foundation
@testable import Petfinder

enum AnimalsRequestMock: RequestProtocol {
    
    case getAnimals
    
    var requestType: RequestType {
        return .GET
    }
    
    var path: String {
        guard let path = Bundle.main.path(forResource: "AnimalsMock", ofType: "json") else { return "" }
        return path
    }
    
}
