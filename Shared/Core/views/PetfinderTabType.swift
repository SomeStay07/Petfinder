//
//  PetfinderTabType.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import Foundation

enum PetfinderTabType {
    case nearYou, search
    
    static func deepLinkType(url: URL) -> PetfinderTabType {
        if url.scheme == "petfind" {
            switch url.host {
            case "nearYou":
                return .nearYou
            case "search":
                return .search
            default:
                return .nearYou
            }
        }
        
        return .nearYou
    }
    
}
