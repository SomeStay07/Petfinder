//
//  SearchFilterView.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import SwiftUI

struct SearchFilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        Form {
            Section {
                Picker("Age", selection: $viewModel.ageSelection) {
                    ForEach(AnimalSearchAge.allCases, id: \.self) { age in
                        Text(age.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.ageSelection) { _ in
                    viewModel.search()
                }
                
                Picker("Type", selection: $viewModel.typeSelection) {
                    ForEach(AnimalSearchType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized)
                    }
                }
                .onChange(of: viewModel.typeSelection) { _ in
                    viewModel.search()
                }
            } footer: {
                Text("You can mix both, age and type, to make a more accurate search.")
            }
            
            Button("Clear", role: .destructive, action: viewModel.clearFilters)
            Button("Done") {
                dismiss()
            }
        }
        .navigationBarTitle("Filters")
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                }
            }
        }
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        NavigationView {
            SearchFilterView(
                viewModel: SearchViewModel(
                    animalSearcher: AnimalSearcherMock(),
                    animalStore: AnimalStoreService(context: context)
                )
            )
        }
    }
}

