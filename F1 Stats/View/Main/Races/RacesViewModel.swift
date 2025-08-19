//
//  RacesViewModel.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

class RacesViewModel: ObservableObject {
    private let networkManager: NetworkManager = NetworkManager.shared
    
    private var races: [Race] = []
    
    @Published var searchText: String = ""
    
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    var filteredRaces: [Race] {
        guard !searchText.isEmpty else {
            return races
        }
        
        return races.filter {
            $0.raceName.lowercased().contains(searchText.lowercased())
        }
    }
    
    @MainActor
    func fetchRaces() {
        isLoading = true
        errorMessage = nil
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                let response: RacesResponse = try await networkManager.get(from: .races)
                races = response.races
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
