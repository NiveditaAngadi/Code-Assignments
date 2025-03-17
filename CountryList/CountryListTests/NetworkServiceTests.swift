//
//  NetworkServiceTests.swift
//  CountryListTests
//
//  Created by Nivedita Angadi on 12/02/25.
//

import XCTest
@testable import CountryList

class NetworkServiceTests: XCTestCase {
    var networkService: NetworkService!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        networkService = NetworkService(session: urlSession)
    }
    
    override func tearDown() {
        networkService = nil
        urlSession = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() async {
        guard let mockData = loadJSONData(filename: "CountryList") else {
            XCTFail("Failed to load mock countrylist JSON data")
            return
        }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            return(response, mockData)
        }
        
        do {
            let endpoint = Endpoint(path: "/countries/countries")
            let countries: [Country] = try await networkService.request(endPoint: endpoint)
            XCTAssertEqual(countries.count, 2)
            XCTAssertEqual(countries[0].name, "Bangladesh")
        } catch {
            XCTFail("Request should succeed")
        }
    }
    
    func testInvalidURL() async {
        let endpoint = Endpoint(path: "invalid")
        do {
            let countries: [Country] = try await networkService.request(endPoint: endpoint)
            XCTFail("Should throw invalidURL Error")
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidURL)
        }
    }
    
    func testInvalidResponse() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil)!
            return(response, Data())
        }
        
        do {
            let endPoint = Endpoint(path: "")
            let countries: [Country] = try await networkService.request(endPoint: endPoint)
            XCTFail("Should throw invalidResponse Error")
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidResponse)
        }
    }
    
    func testDecodingError() async {
        let invalidData = """
        {"abbreviation": "BD",
        "capital": "Dhaka",
        "currency": "BDT" } 
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            return(response, invalidData)
        }
        
        do {
            let endpoint = Endpoint(path: "/countries/countries")
            let countries: [Country] = try await networkService.request(endPoint: endpoint)
            XCTFail("should throw decoding error")
        } catch {
            if case .decodingFailed = error as? NetworkError {
                //Success
            } else {
                XCTFail("Wrong error type")
            }
        }
    }
}
