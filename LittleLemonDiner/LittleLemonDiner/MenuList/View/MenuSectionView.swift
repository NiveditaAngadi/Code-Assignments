//
//  MenuSectionView.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import SwiftUI

struct MenuSectionView: View {
    @State private var isActive = false
    @State private var shouldShowDetails: Bool = false
    @State private var selectedItem: MenuItem?
    @EnvironmentObject var router: Router

    let menuItems: [MenuItem]
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 8, alignment: .top),
        GridItem(.adaptive(minimum: 150), spacing: 8, alignment: .top),
        GridItem(.adaptive(minimum: 150), spacing: 8, alignment: .top)]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(menuItems) { item in
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.gray)
                        .frame(width: 100, height: 150)
                    Text(item.title)
                        .font(.caption)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .truncationMode(.tail)
                    
                }.padding(8)
                    .onTapGesture {
                        router.navigate(to: .menuDetails(item))
                    }
            }
        }
    }
    
}

#Preview {
    MenuSectionView(menuItems: [MenuItem(title: "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ", price: 150, menuCategory: .food, orderCount: 2, ingredients: [.broccoli, .carrot])])
}
