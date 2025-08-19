//
//  MainView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab(
                MainViewTab.standings.rawValue,
                systemImage: "list.number",
                value: .standings
            ) {
                StandingsView()
            }
            
            Tab(
                MainViewTab.races.rawValue,
                systemImage: "flag.pattern.checkered.2.crossed",
                value: .races,
            ) {
                RacesView()
            }
        }
        .environmentObject(coordinator)
        .fullScreenCover(
            item: $coordinator.item,
            onDismiss: coordinator.onDismiss
        ) { item in
            switch item {
            case .settings:
                SettingsView()
                    .environmentObject(coordinator)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
