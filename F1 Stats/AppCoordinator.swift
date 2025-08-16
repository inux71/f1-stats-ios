//
//  AppCoordinator.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject, Navigable {
    typealias Destination = AppDestination
    
    @Published var path = NavigationPath()
    
    func navigate(to destination: AppDestination) {
        self.path.append(destination)
    }
    
    func navigateBack() {
        guard !self.path.isEmpty else { return }
        
        self.path.removeLast()
    }
}
