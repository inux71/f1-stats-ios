//
//  DriverDetailsViewModel.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

class DriverDetailsViewModel: ObservableObject {
    private let networkManager: NetworkManager = NetworkManager.shared
    
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var informationMessage: String? = nil
    
    @Published private(set) var driver: Driver? = nil
    
    var title: String {
        guard let driver else {
            return ""
        }
        
        return "\(driver.name) \(driver.surname)"
    }
    
    @MainActor
    func fetchDriver(id: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            defer {
                isLoading = false
            }
            
            do {
                let response: DriverResponse = try await networkManager.get(from: .driver(id: id))
                driver = response.driver.first
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
