//
//  RequestLocationView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI
import CoreLocationUI

struct RequestLocationView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Image("creature_dog-and-bone")
                .resizable()
                .frame(width: 240, height: 240)
            Text(
        """
        To find pets near you, first, you need to
        share your current location.
        """
            )
            .multilineTextAlignment(.center)
            LocationButton {
                locationManager.requestWhenInUseAuthorization()
            }
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            locationManager.updateAuthorizationStatus()
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

struct RequestLocationView_Previews: PreviewProvider {
    
    static var previews: some View {
        RequestLocationView()
            .environmentObject(LocationManager())
    }
    
}
