//
//  PetfinderOnboardingView.swift
//  PetfinderOnboarding
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

public struct PetfinderOnboardingView: View {
    
    @State var currentPageIndex = 0
    
    private var onNext: (_ currentIndex: Int) -> Void = { _ in }
    private var onSkip: () -> Void = {}
    private var items: [OnboardingModel] = []
    
    private var nextButtonTitle: String {
        items[currentPageIndex].nextButtonTitle
    }
    
    private var skipButtonTitle: String {
        items[currentPageIndex].skipButtonTitle
    }
    
    public init(items: [OnboardingModel]) {
        self.items = items
    }
        
    public var body: some View {
        if items.isEmpty {
            Text("No items to show.")
        } else {
            VStack {
                TabView(selection: $currentPageIndex) {
                    ForEach(0..<items.count) { index in
                        OnboardingView(onboarding: items[index])
                            .tag(index)
                    }
                }
                .padding(.bottom, 10)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .onAppear(perform: setupPageControlAppearance)
                
                Button(action: next) {
                    Text(nextButtonTitle)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                }
                .animation(nil, value: currentPageIndex)
                .buttonStyle(OnboardingButtonStyle(color: .blue))
                
                Button(action: onSkip) {
                    Text(skipButtonTitle)
                        .frame(maxWidth: .infinity, maxHeight: 44)
                }
                .animation(nil, value: currentPageIndex)
                .buttonStyle(OnboardingButtonStyle(color: .dark))
                .padding(.bottom, 20)
            }
            .background(OnboardingBackgroundView())
        }
    }
    
    public func onNext(action: @escaping (_ currentIndex: Int) -> Void) -> Self {
        var petfinderOnboardingView = self
        petfinderOnboardingView.onNext = action
        return petfinderOnboardingView
    }
    
    public func onSkip(action: @escaping () -> Void) -> Self {
        var petfinderOnboardingView = self
        petfinderOnboardingView.onSkip = action
        return petfinderOnboardingView
    }
    
    private func setupPageControlAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.blue)
    }
    
    private func next() {
        withAnimation {
            if currentPageIndex + 1 < items.count {
                currentPageIndex += 1
            } else {
                currentPageIndex = 0
            }
        }
        onNext(currentPageIndex)
    }
}

struct PetfinderOnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        PetfinderOnboardingView(items: mockOnboardingModel)
    }
    
}

// MARK: - Previews Onboarding.

private extension PreviewProvider {
    
    static var mockOnboardingModel: [OnboardingModel] {
        [
            OnboardingModel(
                title: "Welcome to\n Petfinder",
                description: "Looking for a Pet?\n Then you're at the right place",
                image: .bird
            ),
            OnboardingModel(
                title: "Search...",
                description: "Search from a list of our huge database of animals.",
                image: .dogBoneStand,
                nextButtonTitle: "Allow"
            ),
            OnboardingModel(
                title: "Nearby",
                description: "Find pets to adopt from nearby your place...",
                image: .chameleon
            )
        ]
    }
    
}

struct OnboardingButtonStyle: ButtonStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(color)
            .clipShape(Capsule())
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
    }
    
}
