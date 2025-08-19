//
//  API.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

enum API {
    case circuit(id: String)
    
    case driver(id: String)
    
    case races
    
    case standingsConstructors
    case standingsDrivers
    
    case team(id: String)
    
    var path: String {
        switch self {
        case .circuit(id: let id):
            "circuits/\(id)"
            
        case .driver(id: let id):
            "drivers/\(id)"
            
        case .races:
            "current"
            
        case .standingsConstructors:
            "current/constructors-championship"
        case .standingsDrivers:
            "current/drivers-championship"
            
        case .team(id: let id):
            "teams/\(id)"
        }
    }
}
