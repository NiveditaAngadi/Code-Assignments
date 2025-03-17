//
//  ViewModel.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import SwiftUI

enum ViewState: Equatable {
    case idle
    case loading
    case failed(Error)
    case loaded
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading),
            (.loaded, .loaded):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                   (lhsError as NSError).code == (rhsError as NSError).code
        default:
            return false
        }
    }
}

protocol ViewModel: ObservableObject {
    associatedtype DataType
    
    var state: ViewState { get set }
    var data: DataType? { get set }
    var errorMessage: String? { get set }
}

extension ViewModel {
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        state = .failed(error)
    }
}
