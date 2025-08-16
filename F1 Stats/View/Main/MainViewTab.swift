//
//  MainViewTab.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

enum MainViewTab: String, Hashable {
    case standings = "Standings"
    case races = "Races"
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}
