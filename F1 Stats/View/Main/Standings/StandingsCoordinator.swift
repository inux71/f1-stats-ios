//
//  StandingsCoordinator.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation
import SwiftUI

class StandingsCoordinator: ObservableObject, Navigable {
    typealias Destination = StandingsDestination
    
    @Published var path = NavigationPath()
    
    func navigate(to destination: StandingsDestination) {
        self.path.append(destination)
    }
    
    func navigateBack() {
        guard !self.path.isEmpty else { return }
        
        self.path.removeLast()
    }
}
