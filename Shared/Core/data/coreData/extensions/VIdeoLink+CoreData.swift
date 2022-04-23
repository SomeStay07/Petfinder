//
//  VIdeoLink+CoreData.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import CoreData

// MARK: - CoreDataPersistable

extension VideoLink: CoreDataPersistable {
    
    var keyMap: [PartialKeyPath<VideoLink>: String] {
        [
            \.embedded: "embedded",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = VideoLinkEntity
    
}
