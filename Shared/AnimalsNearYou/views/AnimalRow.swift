//
//  AnimalRow.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

import SwiftUI

struct AnimalRow: View {
    let animal: AnimalEntity
    
    var animalName: String
    
    var animalType: String
    
    var animalDescription: String
    
    var animalBreedAndType: String {
        "\(animal.breed) \(animalType)"
    }
    
    init(animal: AnimalEntity) {
        self.animal = animal
        animalName = animal.name ?? ""
        animalType = animal.type ?? ""
        animalDescription = animal.desc ?? ""
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: animal.picture) { image in
                image
                    .resizable()
                    .accessibilityLabel("Image of Pet")
            } placeholder: {
                Image("logo")
                    .resizable()
                    .accessibilityLabel("Placeholder Logo")
                    .overlay {
                        if animal.picture != nil {
                            ProgressView()
                                .accessibilityLabel("Image loading indicator")
                                .accessibilityHidden(true)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.gray.opacity(0.4))
                        }
                    }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 112, height: 112)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(animalName)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("sheep_sans", size: 18, relativeTo: .title3))
                    .accessibilityLabel(animalName)
                Text(animalBreedAndType)
                    .font(Font.custom("sheep_sans", size: 15, relativeTo: .callout))
                    .accessibilityLabel(animalBreedAndType)
                    .accessibilityHidden(true)
                if let description = animal.desc {
                    Text(description)
                        .lineLimit(2)
                        .font(.footnote)
                        .accessibilityLabel(description)
                        .accessibilityHidden(true)
                }
                
                HStack {
                    Text(animal.age.rawValue)
                        .modifier(AnimalAttributesCard(color: animal.age.color))
                        .accessibilityLabel(animal.age.rawValue)
                        .accessibilityHidden(true)
                    Text(animal.gender.rawValue)
                        .modifier(AnimalAttributesCard(color: .pink))
                        .accessibilityLabel(animal.gender.rawValue)
                }
            }
            .lineLimit(1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent("Age", animal.age.rawValue, importance: .high)
        .accessibilityCustomContent("Breed", animal.breed)
        .accessibilityCustomContent("Type", animalType)
        .accessibilityCustomContent("Description", animalDescription)
    }
}

struct AnimalRow_Previews: PreviewProvider {
    
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            AnimalRow(animal: animal)
        }
    }
    
}
