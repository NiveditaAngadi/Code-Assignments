//
//  Menu.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import Foundation
protocol MenuItemProtocol {
    var id: UUID { get }
    var price: Double { get }
    var title: String { get }
    var menuCategory: MenuCategory { get }
    var orderCount: Int { get set }
    var ingredients: [Ingredient] { get set }
}

struct MenuItem: Identifiable, MenuItemProtocol, Codable, Equatable, Hashable {
    var id: UUID
    var title: String
    var price: Double
    var menuCategory: MenuCategory
    var orderCount: Int
    var ingredients: [Ingredient]
    
    init(id: UUID = UUID(), title: String, price: Double, menuCategory: MenuCategory, orderCount: Int, ingredients: [Ingredient]) {
        self.id = id
        self.title = title
        self.price = price
        self.menuCategory = menuCategory
        self.orderCount = orderCount
        self.ingredients = ingredients
    }
}

struct MenuItemData: Identifiable {
    let id: UUID
    let title: String
    let items: [MenuItem]
    
    init(id: UUID = UUID(), title: String, items: [MenuItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}
