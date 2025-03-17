//
//  Test+JSON.swift
//  CountryListTests
//
//  Created by Nivedita Angadi on 12/02/25.
//

import XCTest

extension XCTestCase {
    func loadJSONData(filename: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
            XCTFail("Failed to find \(filename).json in the test bundle")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            XCTFail("Failed to load \(filename).json: \(error.localizedDescription)")
            return nil
        }
    }
}
