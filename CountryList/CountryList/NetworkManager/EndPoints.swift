//
//  EndPoints.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Encodable?
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.sampleapis.com"
        components.path = path
        
        return components.url
    }
    
    init(
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Encodable? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
}
