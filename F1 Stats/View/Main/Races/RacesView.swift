//
//  RacesView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct RacesView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @StateObject private var coordinator = RacesCoordinator()
    @StateObject private var viewModel = RacesViewModel()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            List {
                Section {
                    ForEach(viewModel.filteredRaces) { race in
                        Card(
                            leadingText: "#\(race.round)",
                            title: race.raceName,
                            subtitle: "\(race.circuit.city), \(race.circuit.country)"
                        )
                        .onTapGesture {
                            coordinator.navigate(to: .circuit(id: race.circuit.circuitId))
                        }
                    }
                }
            }
            .navigationTitle("Races")
            .navigationDestination(for: RacesDestination.self) { destination in
                switch destination {
                case .circuit(id: let id):
                    CircuitView(id: id)
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
            viewModel.fetchRaces()
        }
        .overlay {
            if viewModel.filteredRaces.isEmpty {
                ContentUnavailableView(
                    "No races found",
                    systemImage: "flag.pattern.checkered"
                )
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
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
        RacesView()
    }
    .environmentObject(AppCoordinator())
}
