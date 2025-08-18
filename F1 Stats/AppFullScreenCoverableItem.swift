//
//  AppFullScreenCoverableItem.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import Foundation

enum AppFullScreenCoverableItem: String, Identifiable {
    case settings = "settings"
    
    var id: String {
        rawValue
    }
}
