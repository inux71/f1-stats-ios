//
//  StandingsViewModel.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

class StandingsViewModel: ObservableObject {
    private let networkManager: NetworkManager = NetworkManager.shared
    
    private var driversChampionship: [DriverChampionship] = []
    private var constructorsChampionship: [ConstructorChampionship] = []
    
    @Published var searchText: String = ""
    @Published var selectedChampionship: Championship = .drivers
    
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    var filteredDrivers: [DriverChampionship] {
        guard !searchText.isEmpty else {
            return driversChampionship
        }
        
        return driversChampionship.filter {
            $0.driver.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var filteredConstructors: [ConstructorChampionship] {
        guard !searchText.isEmpty else {
            return constructorsChampionship
        }
        
        return constructorsChampionship.filter {
            $0.team.teamName.lowercased().contains(searchText.lowercased())
        }
    }
    
    @MainActor
    func fetchChampionship(for championship: Championship) {
        isLoading = true
        errorMessage = nil
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                switch championship {
                case .drivers:
                    let standings: DriverStanding = try await networkManager.get(from: .standingsDrivers)
                    driversChampionship = standings.driversChampionship
                case .constructors:
                    let standings: ConstructorStanding = try await networkManager.get(from: .standingsConstructors)
                    constructorsChampionship = standings.constructorsChampionship
                }
            } catch {
                guard let error = error as? NetworkError else {
                    errorMessage = "An unknown error occurred."
                    return
                }
                
                switch error {
                case .invalidURL:
                    errorMessage = "Invalid API endpoint."
                case .notFound:
                    errorMessage = "Resource not found."
                case .internalServer:
                    errorMessage = "Internal server error."
                case .invalidResponse:
                    errorMessage = "Invalid server response."
                case .invalidDecoding:
                    errorMessage = "Error decoding JSON."
                case .unknown:
                    errorMessage = "An unknown error occurred."
                }
            }
        }
    }
}
