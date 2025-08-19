//
//  Team.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

struct Team: Decodable {
    let teamId: String
    let teamName: String
    let teamNationality: String
    let firstAppeareance: Int
    let constructorsChampionships: Int
    let driversChampionships: Int
    let url: String
}
