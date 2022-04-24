//
//  OnboardingModel.swift
//  PetfinderOnboarding
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

public struct OnboardingModel: Identifiable {
    
    public let id = UUID()
    
    let title: String
    let description: String
    let image: Image
    let nextButtonTitle: String
    let skipButtonTitle: String
    
    public init(
        title: String,
        description: String,
        image: Image,
        nextButtonTitle: String = "Next",
        skipButtonTitle: String = "Skip"
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.nextButtonTitle = nextButtonTitle
        self.skipButtonTitle = skipButtonTitle
    }
}
