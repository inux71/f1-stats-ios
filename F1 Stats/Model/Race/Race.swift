//
//  Race.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

struct Race: Decodable, Identifiable {
    let raceId: String
    let raceName: String
    let laps: Int
    let round: Int
    let circuit: RaceCircuit
    
    var id: String {
        raceId
    }
}
