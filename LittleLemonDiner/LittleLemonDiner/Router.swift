//
//  Router.swift
//  LittleLemonDiner
//
//  Created by Nivedita Angadi on 11/03/25.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var stacks: [Destination] = []
    @Published var root: RootFlow = .MenuList
    
    enum Destination: Hashable, Codable, Equatable {
        case menuList
        case menuDetails(_ item: MenuItem)
        case menuFilterOptionView(_ isPresented: Bool)
    }
    
    enum RootFlow {
        case MenuList
    }
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
        stacks.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
        stacks.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
        stacks.removeAll()
    }
    
    func navigateBack(to target: Destination) {
        guard !stacks.isEmpty else {return}
        while let last = stacks.last, last != target {
            navigationPath.removeLast()
            stacks.removeLast()
        }
    }
    
    func setRoot(_ root: RootFlow) {
        self.root = root
        navigateToRoot()
    }
}

extension Router {
    @ViewBuilder
    func destination(for flow: Destination) -> some View {
        switch flow {
        case .menuList: MenuItemsView()
        case .menuDetails(let item): MenuItemDetailsView(item: item)
        case .menuFilterOptionView(let isPresented): MenuItemsOptionView(isPresented: Binding.constant(isPresented))
        }
    }
}
