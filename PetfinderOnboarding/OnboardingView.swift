//
//  OnboardingView.swift
//  PetfinderOnboarding
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    let onboarding: OnboardingModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(.white)
                .shadow(radius: 12)
                .padding(.horizontal, 20)
            VStack(alignment: .center) {
                VStack {
                    Text(onboarding.title)
                        .foregroundColor(.dark)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    Text(onboarding.description)
                        .foregroundColor(.dark)
                        .multilineTextAlignment(.center)
                        .padding([.top, .bottom], 10)
                        .padding(.horizontal, 10)
                    onboarding.image
                        .resizable()
                        .frame(width: 140, height: 140, alignment: .center)
                        .foregroundColor(.dark)
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView(
                onboarding: OnboardingModel(
                    title: "Welcome to Petfinder",
                    description: "Looking for a Pet? Then you're at the right place",
                    image: .bird
                )
            )
        }
    }
}
