//
//  PetfinderTabNavigator.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import Foundation

class PetfinderTabNavigator: ObservableObject {
    
    @Published var currentTab: PetfinderTabType =  .nearYou
    
    func switchTab(to tab: PetfinderTabType) {
        currentTab = tab
    }
    
}

extension PetfinderTabNavigator: Hashable {
    
    static func == (lhs: PetfinderTabNavigator, rhs: PetfinderTabNavigator) -> Bool {
        lhs.currentTab == rhs.currentTab
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(currentTab)
    }
    
}
