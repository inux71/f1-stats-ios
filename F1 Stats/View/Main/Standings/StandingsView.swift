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
                        ForEach(viewModel.filteredDrivers) { driverStanding in
                            Card(
                                leadingText: "#\(driverStanding.position)",
                                title: "\(driverStanding.driver.name) \(driverStanding.driver.surname)",
                                subtitle: driverStanding.team.teamName,
                                trailingText: "\(driverStanding.points)"
                            )
                            .onTapGesture {
                                coordinator.navigate(to: .driver(id: driverStanding.driverId))
                            }
                        }
                    case .constructors:
                        ForEach(viewModel.filteredConstructors) { constructorStanding in
                            Card(
                                leadingText: "#\(constructorStanding.position)",
                                title: constructorStanding.team.teamName,
                                subtitle: constructorStanding.team.country,
                                trailingText: "\(constructorStanding.points)"
                            )
                            .onTapGesture {
                                coordinator.navigate(to: .team(id: constructorStanding.teamId))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Standings")
            .navigationDestination(for: StandingsDestination.self) { destination in
                switch destination {
                case .driver(id: let id):
                    DriverDetailsView(id: id)
                case .team(id: let id):
                    TeamDetailsView(id: id)
                }
            }
            .searchable(text: $viewModel.searchText)
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
                if viewModel.filteredDrivers.isEmpty {
                    ContentUnavailableView(
                        "No drivers found",
                        systemImage: "steeringwheel"
                    )
                }
            case .constructors:
                if viewModel.filteredConstructors.isEmpty {
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
