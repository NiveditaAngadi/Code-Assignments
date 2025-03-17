//
//  LittleLemonDinerApp.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 10/03/25.
//

import SwiftUI

@main
struct LittleLemonDinerApp: App {
    @ObservedObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                if router.root == .MenuList {
                    MenuItemsView()
                        .navigationDestination(for: Router.Destination.self) { destination in
                            router.destination(for: destination)
                        }
                }
            }
            .environmentObject(router)
        }
    }
}
