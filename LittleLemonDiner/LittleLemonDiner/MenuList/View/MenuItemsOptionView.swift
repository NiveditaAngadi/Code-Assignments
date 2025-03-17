//
//  MenuItemsOptionView.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import SwiftUI

struct MenuItemsOptionView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        List {
            Section(header: Text("Selected Categories")) {
                ForEach(MenuCategory.allCases, id: \.self) { category in
                    Text(category.capitalized)
                        .font(.caption)
                }
            }
            
            Section(header: Text("Selected Categories")) {
                ForEach(SortCategory.allCases, id: \.self) { category in
                    Text(category.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                }
            }
        }
        .navigationTitle(Text("Filter"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                }
            }
        }
    }
}

#Preview {
    MenuItemsOptionView(isPresented: Binding.constant(true))
}
