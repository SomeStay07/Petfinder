//
//  Bundle+Extension.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

// MARK: - Returns default bundle property.

extension Bundle {
    static var module: Bundle? {
        Bundle(
            identifier: "com.tcheberda.Petfinder"
        )
    }
}
