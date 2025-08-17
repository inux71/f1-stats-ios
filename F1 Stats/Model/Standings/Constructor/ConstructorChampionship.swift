//
//  ConstructorChampionship.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct ConstructorChampionship: Decodable, Identifiable {
    let teamId: String
    let points: Int
    let position: Int
    let wins: Int
    let team: ConstructorChampionshipTeam
    
    var id: String {
        teamId
    }
}
