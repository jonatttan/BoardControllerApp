//
//  PinStatus.swift
//  ControllESP
//
//  Created by Jonattan Sousa on 21/11/24.
//

import Foundation

struct PinStatus: Codable, Identifiable {
    var id: Int
    var type: String
    var state: Bool
}
