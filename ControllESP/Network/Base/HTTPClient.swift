//
//  HTTPClient.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import Foundation

let apiEnd = ProcessInfo.processInfo.environment["API_END"] ?? String()

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError>
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError> {
        
        let controllerApiUrl = URL(string: "\(apiEnd)\(endpoint.path)")
        print(">> ", apiEnd)
        
        guard let url = controllerApiUrl else {
            return .failure(.invalidUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        /// Request
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let responseModel else {
                    return .success(nil)
                }
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknow)
        }
        
    }
}
