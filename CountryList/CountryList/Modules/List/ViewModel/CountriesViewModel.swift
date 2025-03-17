//
//  CountryViewModel.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import Foundation

class CountriesViewModel: ViewModel {
    @Published var state: ViewState = .idle
    @Published var data: [Country]?
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchCountries() async {
        state = .loading
        errorMessage = nil
        
        do {
            let endpoint = Endpoint(path: "/countries/countries")
            data = try await networkService.request(endPoint: endpoint)
            state = .loaded
        } catch let error as NetworkError {
            handleNetworkError(error)
        } catch {
            handleError(error)
        }
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        switch error {
        case .invalidURL:
            errorMessage = "Invalid URL"
        case .invalidResponse:
            errorMessage = "Invalid URL."
        case .noInternetConnection:
            errorMessage = "No internet connection."
        case .requestFailed(let error):
            errorMessage = "Request failed with status code: \(error.localizedDescription)"
        case .decodingFailed(let underlyingError):
            errorMessage = "Failed to decode response: \(underlyingError.localizedDescription)"
        }

        state  = .failed(error)
    }
}
