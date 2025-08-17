//
//  DriverChampionshipTeam.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct DriverChampionshipTeam: Decodable {
    let teamId: String
    let teamName: String
    let country: String
    let url: String
}
