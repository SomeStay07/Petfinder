//
//  AnimalListView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

import SwiftUI

struct AnimalListView<Content, Data>: View where Content: View,
                                                 Data: RandomAccessCollection,
                                                 Data.Element: AnimalEntity {
    
    let animals: Data
    
    let footer: Content
    
    init(animals: Data, @ViewBuilder footer: () -> Content) {
        self.animals = animals
        self.footer = footer()
    }
    
    init(animals: Data) where Content == EmptyView {
        self.init(animals: animals) {
            EmptyView()
        }
    }
    
    var body: some View {
        List {
            ForEach(animals) { animal in
                NavigationLink(destination: AnimalDetailsView(animal: animal)) {
                    AnimalRow(animal: animal)
                }
            }
            
            footer
        }
        .listStyle(.plain)
    }
}

struct AnimalListView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            AnimalListView(animals: CoreDataHelper.getTestAnimalEntities() ?? [])
        }
        
        NavigationView {
            AnimalListView(animals: []) {
                Text("This is a footer")
            }
        }
    }
    
}
