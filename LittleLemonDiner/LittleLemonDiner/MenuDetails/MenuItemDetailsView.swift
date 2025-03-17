//
//  MenuItemDetailsView.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import SwiftUI

struct MenuItemDetailsView: View {
    let item: MenuItem
    
    var body: some View {
        ScrollView {
            VStack  {
                HStack {
                    Text(item.title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                    Spacer()
                }
                Spacer()
                Image("Little Lemon logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .leading, .trailing], 40)
                    .padding(.bottom, 20)
                Text("Price:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(item.price)")
                    .font(.caption)
                    .fontWeight(.regular)
                Text("Ordered:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("\(item.orderCount)")
                    .font(.caption)
                    .fontWeight(.regular)
                Text("Ingredients:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                VStack {
                    ForEach(item.ingredients, id: \.self) { item in
                        Text(item.rawValue)
                            .font(.caption)
                            .fontWeight(.regular)
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    MenuItemDetailsView(item: MenuItem(title: "Biriyani", price: 160, menuCategory: .food, orderCount: 2, ingredients: [.broccoli,.carrot, .pasta, .potato, .spinach, .broccoli,.carrot, .pasta, .potato, .spinach]))
}
