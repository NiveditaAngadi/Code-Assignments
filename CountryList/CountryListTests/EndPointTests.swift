//
//  EndPointTests.swift
//  CountryListTests
//
//  Created by Nivedita Angadi on 12/02/25.
//

import XCTest
@testable import CountryList

class EndPointTests: XCTestCase {
    
    func testValidEndPointURL() {
        let endpoint = Endpoint(path: "/countries/countries")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://api.sampleapis.com/countries/countries")
    }
    
    func testInvalidEndpointURL() {
        let endpoint = Endpoint(path: "invalid endpoint")
        XCTAssertNil(endpoint.url)
    }
}
