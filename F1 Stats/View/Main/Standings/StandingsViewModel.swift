//
//  StandingsViewModel.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

class StandingsViewModel: ObservableObject {
    private let standingsService = StandingsService()
    
    @Published var selectedChampionship: Championship = .drivers
    
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published private(set) var driversChampionship: [DriverChampionship] = []
    @Published private(set) var constructorsChampionship: [ConstructorChampionship] = []
    
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
                    let standings: DriverStanding = try await standingsService.getStandings(for: .drivers)
                    driversChampionship = standings.driversChampionship
                case .constructors:
                    let standings: ConstructorStanding = try await standingsService.getStandings(for: .constructors)
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
