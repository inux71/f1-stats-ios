//
//  DriverChampionship.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct DriverChampionship: Decodable, Identifiable {
    let driverId: String
    let teamId: String
    let points: Int
    let position: Int
    let wins: Int
    let driver: DriverChampionshipDriver
    let team: DriverChampionshipTeam
    
    var id: String {
        driverId
    }
}
