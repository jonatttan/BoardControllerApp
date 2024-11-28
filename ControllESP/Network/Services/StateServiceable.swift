//
//  StateServiceable.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import Foundation

protocol StateServiceable {
    func getStatus() async throws -> Result<[PinStatus]?, RequestError>
    func setStatus(endpoint: EndpointOption) async throws -> Result<Bool?, RequestError>
}

struct StateNetworkingService: HTTPClient, StateServiceable {
    func getStatus() async throws -> Result<[PinStatus]?, RequestError> {
        return await sendRequest(endpoint: EndpointOption.readState, responseModel: [PinStatus].self)
    }
    
    func setStatus(endpoint: EndpointOption) async throws -> Result<Bool?, RequestError> {
        return await sendRequest(endpoint: endpoint, responseModel: Bool.self)
    }
}
