//
//  AnimalLocationView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import SwiftUI
import MapKit

struct AnimalLocationView: View {
    
    let animal: AnimalEntity
    
    @StateObject var addressFetcher = AddressFetcher()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Location")
                .font(.headline)
            Text(animal.address)
                .font(.subheadline)
                .textSelection(.enabled)
            
            Button(action: openAddressInMaps) {
                Map(coordinateRegion: $addressFetcher.coordinates, interactionModes: [])
            }
            .buttonStyle(.plain)
            .frame(height: 200)
            .cornerRadius(16)
            .task {
                await addressFetcher.search(by: animal.address)
            }
        }
    }
    
    func openAddressInMaps() {
        let placemark = MKPlacemark(coordinate: addressFetcher.coordinates.center)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: nil)
    }
    
}

struct AnimalLocationView_Previews: PreviewProvider {
    
    static var previews: some View {
        if let animal = CoreDataHelper.getTestAnimalEntity() {
            AnimalLocationView(animal: animal)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
    
}

