//
//  ContentView.swift
//  Shared
//
//  Created by Timur Cheberda on 22.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    var body: some View {
        TabView {
            AnimalsNearYouView()
                .tabItem {
                    Label("Near you", systemImage: "location")
                }
                .environment(\.managedObjectContext, managedObjectContext)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
