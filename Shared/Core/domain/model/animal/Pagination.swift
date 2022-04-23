//
//  Pagination.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

struct Pagination: Codable {
    let countPerPage: Int
    let totalCount: Int
    let currentPage: Int
    let totalPages: Int
}
