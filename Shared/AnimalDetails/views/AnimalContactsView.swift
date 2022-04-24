//
//  AnimalContactsView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import SwiftUI

struct AnimalContactsView: View {
    
    let animal: AnimalEntity
    
    init(animal: AnimalEntity) {
        self.animal = animal
    }
    
    var phoneNumber: String? {
        animal.contact?.phone
    }
    
    var emailAddress: String? {
        animal.contact?.email
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Contact")
                .font(.headline)
            HStack {
                if let phoneLink = animal.phoneLink, let phoneNumber = phoneNumber {
                    AnimalContactLink(
                        title: phoneNumber,
                        iconName: "phone.fill",
                        url: phoneLink,
                        color: .green
                    )
                }
                if let emailLink = animal.emailLink, let emailAddress = emailAddress {
                    AnimalContactLink(
                        title: emailAddress,
                        iconName: "envelope.fill",
                        url: emailLink,
                        color: .blue
                    )
                }
            }
        }
    }
}

struct AnimalContactsView_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            AnimalContactsView(animal: animal)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
