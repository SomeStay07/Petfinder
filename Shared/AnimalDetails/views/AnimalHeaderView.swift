//
//  AnimalHeaderView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import SwiftUI

struct AnimalHeaderView: View {
    
    let animal: AnimalEntity
        
    @Binding var zoomed: Bool
    @Binding var favorited: Bool
    
    let geometry: GeometryProxy
    
    var body: some View {
        if zoomed {
            LazyVStack {
                AnimalImage(animalPicture: animal.picture, zoomed: $zoomed, geometry: geometry)
                HeaderTitle(animal: animal, zoomed: $zoomed, geometry: geometry)
            }
        } else {
            HStack {
                AnimalImage(animalPicture: animal.picture, zoomed: $zoomed, geometry: geometry)
                HeaderTitle(animal: animal, zoomed: $zoomed, geometry: geometry)
                Image(systemName: favorited ? "heart.fill" : "heart")
                    .font(.system(size: 50))
                    .foregroundColor( favorited ? Color(.systemRed) : Color(.label))
                    .frame(minWidth: 50, maxWidth: 50, minHeight: 50, maxHeight: 50)
                    .animation(favorited ? .interpolatingSpring(
                        mass: 5,
                        stiffness: 3.0,
                        damping: 1.0,
                        initialVelocity: 1) : .default, value: $favorited.wrappedValue)
                    .onTapGesture {
                        $favorited.wrappedValue.toggle()
                    }
                Spacer(minLength: 25)
            }
        }
    }
}

struct AnimalImage: View {
    let animalPicture: URL?
    @Binding var zoomed: Bool
    let geometry: GeometryProxy
    
    var body: some View {
        AsyncImage(url: animalPicture) { image in
            image
                .resizable()
                .aspectRatio(zoomed ? nil : 1, contentMode: zoomed ? .fit : .fill)
        } placeholder: {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    if animalPicture != nil {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.gray.opacity(0.4))
                    }
                }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: zoomed ? 0 : 300)
        )
        .frame(
            width: zoomed ? geometry.frame(in: .local).width : 100,
            height: zoomed ? geometry.frame(in: .global).midX : 100
        )
        .offset(
            x: zoomed ? 0 : 0,
            y: zoomed ? geometry.frame(in: .local).midY / 3 : 0
        )
        .scaleEffect((zoomed ? 5 : 3) / 3)
        .shadow(radius: zoomed ? 10 : 1)
        .animation(.spring(), value: zoomed)
    }
}

struct HeaderTitle: View {
    @Binding var zoomed: Bool
    var geometry: GeometryProxy
    let animalName: String?
    let animalType: String?
    
    let animal: AnimalEntity
    
    init(animal: AnimalEntity, zoomed: Binding<Bool>, geometry: GeometryProxy) {
        self.animal = animal
        self.animalType = animal.type
        self.animalName = animal.name
        self._zoomed = zoomed
        self.geometry = geometry
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(animalName ?? "Default Name")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: zoomed ? .center : .leading)
            Text("\(animal.breed) \(animalType ?? "")")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: zoomed ? .center : .leading)
        }
        .offset(
            x: zoomed ? 0 : 0,
            y: zoomed ? geometry.frame(in: .local).midY : 0
        )
        
        .animation(.spring(), value: zoomed)
    }
}

struct HeaderTitle_Previews: PreviewProvider {
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            Group {
                GeometryReader { geometry in
                    HeaderTitle(animal: animal, zoomed: .constant(true), geometry: geometry)
                }
                .frame(width: 200, height: 150)
                
                GeometryReader { geometry in
                    HeaderTitle(animal: animal, zoomed: .constant(false), geometry: geometry)
                }
                .frame(width: 200, height: 100)
            }
            .previewLayout(.sizeThatFits)
        }
    }
}

struct AnimalHeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            Group {
                GeometryReader { geometry in
                    AnimalHeaderView(animal: animal, zoomed: .constant(true), favorited: .constant(false), geometry: geometry)
                }
                .frame(width: 500, height: 700)
                
                GeometryReader { geometry in
                    AnimalHeaderView(animal: animal, zoomed: .constant(false), favorited: .constant(true), geometry: geometry)
                }
                .frame(width: 500, height: 100)
                
                GeometryReader { geometry in
                    AnimalHeaderView(animal: animal, zoomed: .constant(false), favorited: .constant(false), geometry: geometry)
                }
                .frame(width: 500, height: 100)
            }
            .previewLayout(.sizeThatFits)
        }
    }
    
}

