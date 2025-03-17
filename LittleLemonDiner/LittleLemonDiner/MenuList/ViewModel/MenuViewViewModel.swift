//
//  MenuViewViewModel.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import Foundation

class MenuViewViewModel {
    var foodMenuItems = [MenuItem(title: "French Fries", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Plain Sandwich", price: 180, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Tandoori Paneer Tikka", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Malai Paneer Tikka", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Punjabi Soya Chap", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Hare-Bhare Kabab", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Platter", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Shahi Paneer", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Malai Kofta", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Tandoori Roti", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Paper Dosa", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                         MenuItem(title: "Rava Kesri", price: 160, menuCategory: .food, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli])]
    
    var drinkMenuItems = [MenuItem(title: "Fruit Punch", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Virgin Colada", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Love Valley", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Pomi Twist", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Ginger Fizz", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Italian Smooch", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Devils Kiss", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot]),
                          MenuItem(title: "Fresh Mint Mojito", price: 160, menuCategory: .drink, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.carrot])]
    
    var dessertMenuItems = [MenuItem(title: "Tutti Fruti", price: 160, menuCategory: .dessert, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                            MenuItem(title: "Pineapple", price: 160, menuCategory: .dessert, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                            MenuItem(title: "Kesar Pista", price: 160, menuCategory: .dessert, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli]),
                            MenuItem(title: "Chocolate", price: 160, menuCategory: .dessert, orderCount: 2, ingredients: [Ingredient.tomatoSauce, Ingredient.broccoli])]
    
    var sections: [MenuItemData] {
        [MenuItemData(title: "Food", items: foodMenuItems),
         MenuItemData(title: "Drink", items: drinkMenuItems),
         MenuItemData(title: "Dessert", items: dessertMenuItems)]
    }
}
