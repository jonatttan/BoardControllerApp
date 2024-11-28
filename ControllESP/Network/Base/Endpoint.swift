//
//  Endpoint.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [PinStatus]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "localhost"
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestError: Error {
    case decode
    case invalidUrl
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknow
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Erro na decodificação"
        case .unauthorized:
            return "Sessão expirada"
        default:
            return "Erro desconhecido"
        }
    }
}
