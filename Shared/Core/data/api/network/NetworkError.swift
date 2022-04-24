//
//  NetworkError.swift
//  Petfinder (iOS)
//
//  Created by Timur Cheberda on 22.04.2022.
//

import Foundation

public enum NetworkError: LocalizedError {
    
    case invalidServerResponse
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL string is malformed."
        }
    }
    
}
