//
//  MainView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab(
                MainViewTab.standings.rawValue,
                systemImage: "list.number",
                value: .standings
            ) {
                Text("Standings")
            }
            
            Tab(
                MainViewTab.races.rawValue,
                systemImage: "flag.pattern.checkered.2.crossed",
                value: .races,
            ) {
                Text("Races")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    "Settings",
                    systemImage: "gear"
                ) {
                    coordinator.navigate(to: .settings)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
