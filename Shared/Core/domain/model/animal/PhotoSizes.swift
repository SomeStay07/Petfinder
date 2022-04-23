//
//  PhotoSizes.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

import Foundation

struct PhotoSizes: Codable {
    var id: Int?
    var small: URL?
    var medium: URL?
    var large: URL?
    var full: URL?
}
