//
//  MenuTests.swift
//  LittleLemonDinerTests
//
//  Created by Nivedita Angadi on 12/03/25.
//

import XCTest

@testable import LittleLemonDiner

final class MenuTests: XCTestCase {
    func test_menuItemTitle_init_correctTitle() {
        let viewModel = MenuViewViewModel()
        
        let frenchFriesMenuItem = viewModel.foodMenuItems.first!
        
        XCTAssertEqual(frenchFriesMenuItem.title, "French Fries")
        XCTAssertEqual(frenchFriesMenuItem.ingredients, [Ingredient.tomatoSauce, Ingredient.broccoli])
    }
}


