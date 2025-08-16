//
//  F1_StatsApp.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import SwiftUI

@main
struct F1_StatsApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                MainView() // root view
                    .navigationDestination(for: AppDestination.self) { destination in
                        switch destination {
                        case .settings:
                            Text("XD")
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
