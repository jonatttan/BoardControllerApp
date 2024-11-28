//
//  EndpointOption 2.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import Foundation

enum EndpointOption {
    case readState
    case writeState([PinStatus]?)
}

extension EndpointOption: Endpoint {
    
    var path: String {
        switch self {
        case .readState:
            return "/state"
        case .writeState:
            return "/change"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .readState:
            return .get
        case .writeState:
            return .post
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .readState:
            return nil
        case .writeState:
            return ["Content-Type": "application/json"]
            
        }
    }
    
    var body: [PinStatus]? {
        get {
            switch self {
            case .readState:
                return nil
            case .writeState(body: let bodyState):
                return bodyState
            }
        }
        set { }
    }
    
}
