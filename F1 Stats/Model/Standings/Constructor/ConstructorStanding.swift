//
//  ConstructorStanding.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct ConstructorStanding: Decodable {
    let constructorsChampionship: [ConstructorChampionship]
    
    enum CodingKeys: String, CodingKey {
        case constructorsChampionship = "constructors_championship"
    }
}
