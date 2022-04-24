//
//  ContentView.swift
//  Shared
//
//  Created by Timur Cheberda on 22.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    let locationManager = LocationManager()
    
    @StateObject var tabNavigator = PetfinderTabNavigator()
    
    var body: some View {
        TabView(selection: $tabNavigator.currentTab) {
            AnimalsNearYouView(
                viewModel: AnimalsNearYouViewModel(
                    animalFetcher: FetchAnimalsService(
                        requestManager:
                            RequestManager()
                    ),
                    animalStore: AnimalStoreService(
                        context: PersistenceController.shared.container.newBackgroundContext()
                    )
                )
            )
            .badge(2)
            .tag(PetfinderTabType.nearYou)
            .tabItem {
                Label("Near you", systemImage: "location")
            }
            .environmentObject(locationManager)
            .environment(\.managedObjectContext, managedObjectContext)
            
            SearchView()
                .tag(PetfinderTabType.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environment(\.managedObjectContext, managedObjectContext)
        }
        .onOpenURL { url in
            let type = PetfinderTabType.deepLinkType(url: url)
            self.tabNavigator.switchTab(to: type)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
    
}
