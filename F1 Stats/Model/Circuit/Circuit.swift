//
//  Circuit.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

struct Circuit: Decodable {
    let circuitId: String
    let circuitName: String
    let country: String
    let city: String
    let circuitLength: Int
    let numberOfCorners: Int
    let url: String
}
