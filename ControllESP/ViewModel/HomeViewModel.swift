//
//  HomeViewModel.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    private let service = StateNetworkingService()
    @Published var pinStatus: [PinStatus]
    @Published var loading = true
    
    init() {
        self.pinStatus = []
    }
    
    func getStatus() async throws {
        let result = try await service.getStatus()
        switch result {
        case .success(let response):
            if let response = response {
                DispatchQueue.main.async {
                    self.pinStatus = response
                    self.loading = false
                }
            }
        case .failure(let error):
            throw error
        }
    }
    
    func setStatus() async throws {
        _ = try await service.setStatus(endpoint: .writeState(pinStatus))
        
    }
    
}
