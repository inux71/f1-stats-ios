//
//  DriverStanding.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct DriverStanding: Decodable {
    let driversChampionship: [DriverChampionship]
    
    enum CodingKeys: String, CodingKey {
        case driversChampionship = "drivers_championship"
    }
}
