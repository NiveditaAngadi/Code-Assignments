//
//  CountriesViewModelTests.swift
//  CountryListTests
//
//  Created by Nivedita Angadi on 12/02/25.
//

import XCTest
@testable import CountryList

class CountriesViewModelTests: XCTestCase {
    var viewModel: CountriesViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = CountriesViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testSuccessfulCountriesFetch() async {
        let mockCountries = [
            Country(abbreviation: "BD", capital: "Dhaka", currency: "BDT", id: 1, name: "Bangladesh", phone: "880", population: 162951560, media: Media(flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/1280px-Flag_of_Bangladesh.svg.png", emblem: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/National_emblem_of_Bangladesh.svg/1280px-National_emblem_of_Bangladesh.svg.png", orthographic: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bangladesh_%28orthographic_projection%29.svg/1280px-Bangladesh_(orthographic_projection).svg.png")),
            Country(abbreviation: "BE", capital: "Brussels", currency: "EUR", id: 2, name: "Belgium", phone: "32", population: 11348159, media: Media(flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/1182px-Flag_of_Belgium.svg.png", emblem: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Great_coat_of_arms_of_Belgium.svg/1280px-Great_coat_of_arms_of_Belgium.svg.png", orthographic: ""))]
        
        mockNetworkService.mockResult = .success(mockCountries)
        await viewModel.fetchCountries()
        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertEqual(viewModel.data?.count, 2)
        XCTAssertEqual(viewModel.data?.first?.capital, "Dhaka")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testDecodingErrorHandling() async {
        mockNetworkService.mockResult = .failure(.decodingFailed(NSError.test))
    
        await viewModel.fetchCountries()
        
        XCTAssertEqual(viewModel.errorMessage, "Failed to decode response: test error")
    }
    
    func testRequestFailedHandling() async {
        mockNetworkService.mockResult = .failure(.requestFailed(NSError.test))
        
        await viewModel.fetchCountries()
        XCTAssertEqual(viewModel.errorMessage, "Request failed with status code: test error")
    }
}


class MockNetworkService: NetworkServiceProtocol {
    var mockResult: Result<Any, NetworkError> = .failure(.invalidURL)
    
    func request<T>(endPoint: Endpoint) async throws -> T where T : Decodable {
        switch mockResult {
        case .success(let value):
            if let value = value as? T {
                return value
            }
            throw NetworkError.decodingFailed(NSError.test)
        case .failure(let error):
            throw error
        }
    }
}

extension NSError {
    static var test: NSError {
        NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey : "test error"])
    }
}
