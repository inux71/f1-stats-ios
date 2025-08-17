//
//  Championship.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

enum Championship: String, CaseIterable, Hashable, Identifiable {
    case drivers = "Drivers"
    case constructors = "Constructors"
    
    var id: String { rawValue }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
