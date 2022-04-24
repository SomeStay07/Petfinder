//
//  PetfinderApp.swift
//  Shared
//
//  Created by Timur Cheberda on 22.04.2022.
//

import PetfinderOnboarding
import SwiftUI

@main
struct AppMain: App {
    
    @AppStorage(AppUserDefaultsKeys.onboarding) var shouldPresentOnboarding = true
    
    var onboardingModels: [OnboardingModel] {
        [
            OnboardingModel(
                title: "Welcome to\n Petfinder",
                description: "Looking for a Pet?\n Then you're at the right place",
                image: .bird
            ),
            OnboardingModel(
                title: "Search...",
                description: "Search from a list of our huge database of animals.",
                image: .dogBoneStand
            ),
            OnboardingModel(
                title: "Nearby",
                description: "Find pets to adopt from nearby your place...",
                image: .chameleon
            )
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: $shouldPresentOnboarding, onDismiss: nil) {
                    PetfinderOnboardingView(items: onboardingModels)
                        .onSkip {
                            shouldPresentOnboarding = false
                        }
                }
        }
    }
}
