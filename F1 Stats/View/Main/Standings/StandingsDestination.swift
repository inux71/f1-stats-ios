//
//  StandingsDestination.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

enum StandingsDestination: Hashable {
    case driver(id: String)
    case team(id: String)
}
