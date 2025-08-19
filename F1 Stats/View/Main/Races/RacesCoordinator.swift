//
//  RacesCoordinator.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation
import SwiftUI

class RacesCoordinator: ObservableObject, Navigable {
    typealias Destination = RacesDestination
    
    @Published var path = NavigationPath()
    
    func navigate(to destination: RacesDestination) {
        self.path.append(destination)
    }
    
    func navigateBack() {
        guard !self.path.isEmpty else { return }
        
        self.path.removeLast()
    }
}
