//
//  NetworkManager.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case noInternetConnection
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
         switch (lhs, rhs) {
         case (.invalidURL, .invalidURL),
              (.invalidResponse, .invalidResponse),
              (.noInternetConnection, .noInternetConnection):
             return true

         case (.requestFailed(let lhsError), .requestFailed(let rhsError)):
             return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                    (lhsError as NSError).code == (rhsError as NSError).code

         case (.decodingFailed(let lhsError), .decodingFailed(let rhsError)):
             return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                    (lhsError as NSError).code == (rhsError as NSError).code

         default:
             return false
         }
     }
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endPoint: Endpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endPoint: Endpoint) async throws -> T {
        guard let url = endPoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        
        if let body = endPoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch let error {
                throw NetworkError.decodingFailed(error)
            }
        } catch let error as NetworkError {
            throw error
        } catch let error {
            throw NetworkError.requestFailed(error)
        }
    }
    
    func uploadMultipartFormData(
        endPoint: Endpoint,
        parameters: [String: String],
        fileData: Data,
        fileName: String,
        mimeType: String) async throws -> Data {
        guard let url = endPoint.url else {
            throw NetworkError.invalidURL
        }
            let boundary = UUID().uuidString
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let httpBody = createMultipartBody(parameters: parameters, fileData: fileData, boundary: boundary, fileName: fileName, mimeType: mimeType)
            
            request.httpBody = httpBody
            request.setValue("\(httpBody.count)", forHTTPHeaderField: "Content-Length")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return data
    }
    
    private func createMultipartBody(parameters: [String: String], fileData: Data, boundary: String, fileName: String, mimeType: String) -> Data {
        var body = Data()
        
        // Append text fields
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append file data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Closing boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}
