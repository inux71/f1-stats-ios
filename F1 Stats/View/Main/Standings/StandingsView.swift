//
//  StandingsView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import SwiftUI

struct StandingsView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @StateObject private var coordinator = StandingsCoordinator()
    @StateObject private var viewModel = StandingsViewModel()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            List {
                Section {
                    Picker(
                        "Championship",
                        selection: $viewModel.selectedChampionship
                    ) {
                        ForEach(Championship.allCases) { championship in
                            Text(championship.rawValue)
                                .tag(championship)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    switch viewModel.selectedChampionship {
                    case .drivers:
                        ForEach(viewModel.driversChampionship) { driverStanding in
                            StandingCard(
                                position: driverStanding.position,
                                title: "\(driverStanding.driver.name) \(driverStanding.driver.surname)",
                                subtitle: driverStanding.team.teamName,
                                points: driverStanding.points
                            )
                        }
                    case .constructors:
                        ForEach(viewModel.constructorsChampionship) { constructorStanding in
                            StandingCard(
                                position: constructorStanding.position,
                                title: constructorStanding.team.teamName,
                                subtitle: constructorStanding.team.country,
                                points: constructorStanding.points
                            )
                        }
                    }
                }
            }
            .navigationTitle("Standings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        "Settings",
                        systemImage: "gear"
                    ) {
                        appCoordinator.show(item: .settings)
                    }
                }
            }
        }
        .environmentObject(coordinator)
        .onAppear {
            viewModel.fetchChampionship(for: viewModel.selectedChampionship)
        }
        .onChange(of: viewModel.selectedChampionship) {
            viewModel.fetchChampionship(for: viewModel.selectedChampionship)
        }
        .overlay {
            switch viewModel.selectedChampionship {
            case .drivers:
                if viewModel.driversChampionship.isEmpty {
                    ContentUnavailableView(
                        "No drivers found",
                        systemImage: "steeringwheel"
                    )
                }
            case .constructors:
                if viewModel.constructorsChampionship.isEmpty {
                    ContentUnavailableView(
                        "No constructors found",
                        systemImage: "door.garage.closed"
                    )
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .refreshable {
            viewModel.fetchChampionship(for: viewModel.selectedChampionship)
        }
        .toast(
            message: $viewModel.errorMessage,
            systemImage: "xmark.circle",
            role: .error
        )
    }
}

#Preview {
    NavigationStack {
        StandingsView()
    }
    .environmentObject(AppCoordinator())
}
