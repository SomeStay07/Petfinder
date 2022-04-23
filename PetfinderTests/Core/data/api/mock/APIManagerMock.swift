//
//  APIManagerMock.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import XCTest
@testable import Petfinder

struct APIManagerMock: APIManagerProtocol {
    
    func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
    
    func requestToken() async throws -> Data {
        Data(AccessTokenTestHelper.generateValidToken().utf8)
    }
    
}
