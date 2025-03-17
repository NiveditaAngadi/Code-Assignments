//
//  MenuItemsView.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import SwiftUI

struct MenuItemsView: View {
    var viewModel =  MenuViewViewModel()
    @State var showFilterOptions = false
    @EnvironmentObject var router: Router
    
    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section(header: Text(section.title).font(.headline)) {
                    MenuSectionView(menuItems: section.items)
                }
            }
        }.listStyle(.plain)
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFilterOptions = true
                    }) {
                        Image.init(systemName: "slider.horizontal.3")
                            .resizable()
                            .padding(8)
                    }
                }
            }
            .sheet(isPresented: $showFilterOptions) {
                NavigationView {
                    MenuItemsOptionView(isPresented: $showFilterOptions)
                }
            }
    }
}

#Preview {
    @Previewable var viewModel =  MenuViewViewModel()
    
    MenuItemsView(viewModel: viewModel)
}
