//
//  AnimalDetailsView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

import SwiftUI

struct AnimalDetailsView: View {
    @State var zoomed = false
    @State var favorited = false
    
    let animal: AnimalEntity
    
    var animalDescription: String? {
        animal.desc
    }
    
    var animalName: String? {
        animal.name
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .leading) {
                    LazyVStack(alignment: .leading) {
                        AnimalHeaderView(
                            animal: animal,
                            zoomed: $zoomed,
                            favorited: $favorited,
                            geometry: geometry)
                        .onTapGesture { zoomed.toggle() }
                        Divider()
                            .blur(radius: zoomed ? 20 : 0)
                        PetRankingView(animal: animal)
                            .padding()
                            .blur(radius: zoomed ? 20 : 0)
                        AnimalDetailRow(animal: animal)
                            .blur(radius: zoomed ? 20 : 0)
                        Divider()
                            .blur(radius: zoomed ? 20 : 0)
                        VStack(alignment: .leading, spacing: 24) {
                            if let description = animalDescription {
                                VStack(alignment: .leading) {
                                    Text("Details")
                                        .font(.headline)
                                    Text(description)
                                }
                            }
                            AnimalContactsView(animal: animal)
                            Divider()
                                .blur(radius: zoomed ? 20 : 0)
                            AnimalLocationView(animal: animal)
                        }
                        .blur(radius: zoomed ? 20 : 0)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .animation(.spring(), value: zoomed)
                }
            }
        }
        .navigationTitle(animalName ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnimalsView_Previews: PreviewProvider {
    
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            NavigationView {
                AnimalDetailsView(animal: animal)
                    .previewLayout(.sizeThatFits)
            }
            .previewLayout(.sizeThatFits)
            .previewDisplayName("iPhone SE (2nd generation)")
            
            NavigationView {
                AnimalDetailsView(animal: animal)
            }
            .previewDevice("iPhone 12 Pro")
            .previewDisplayName("iPhone 12 Pro")
        }
    }
    
}
