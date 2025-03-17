//
//  MenuCategory.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import Foundation

enum MenuCategory: String, CaseIterable, Codable{
    case food
    case drink
    case dessert
    
    var capitalized: String {
        rawValue.capitalized
    }
}

enum SortCategory: String, CaseIterable, Codable {
    case mostPopular = "Most Popular"
    case price = "Price $-$$$"
    case az = "A-Z"
}
