//
//  AnimalsNearYouView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 22.04.2022.
//

import SwiftUI

struct AnimalsNearYouView: View {
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel: AnimalsNearYouViewModel
    
    var body: some View {
        NavigationView {
            if locationManager.locationIsDisabled {
                RequestLocationView()
                    .navigationTitle("Animals near you")
            } else {
                AnimalListView(animals: animals) {
                    if !animals.isEmpty && viewModel.hasMoreAnimals {
                        HStack(alignment: .center) {
                            LoadingAnimation()
                                .frame(maxWidth: 125, minHeight: 125)
                            Text("Loading more animals...")
                        }
                        .task {
                            await viewModel.fetchMoreAnimals(location: locationManager.lastSeenLocation)
                        }
                    }
                }
                .task {
                    await viewModel.fetchAnimals(location: locationManager.lastSeenLocation)
                }
                .listStyle(.plain)
                .navigationTitle("Animals near you")
                .overlay {
                    if viewModel.isLoading && animals.isEmpty {
                        ProgressView("Finding Animals near you...")
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AnimalsNearYouView(
                viewModel: AnimalsNearYouViewModel(
                    animalFetcher: AnimalsFetcherMock(),
                    animalStore: AnimalStoreService(
                        context: PersistenceController.preview.container.viewContext
                    )
                )
            )
            
            AnimalsNearYouView(
                viewModel: AnimalsNearYouViewModel(
                    animalFetcher: AnimalsFetcherMock(),
                    animalStore: AnimalStoreService(
                        context: PersistenceController.preview.container.viewContext
                    )
                )
            )
            .preferredColorScheme(.dark)
        }
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
        .environmentObject(LocationManager())
    }
    
}
