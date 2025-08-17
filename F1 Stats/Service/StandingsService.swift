//
//  StandingsService.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import Foundation

class StandingsService {
    func getStandings<T: Decodable>(for championship: Championship) async throws -> T {
        let url: URL
        
        switch championship {
        case .drivers:
            guard let driversURL = URL(string: "\(NetworkConfiguration.BaseURL)/current/drivers-championship") else {
                throw NetworkError.invalidURL
            }
            
            url = driversURL
        case .constructors:
            guard let constructorsURL = URL(string: "\(NetworkConfiguration.BaseURL)/current/constructors-championship") else {
                throw NetworkError.invalidURL
            }
            
            url = constructorsURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let statusCode = response.statusCode
        if statusCode != 200 {
            switch statusCode {
            case 404:
                throw NetworkError.notFound
            case 500:
                throw NetworkError.internalServer
            default:
                throw NetworkError.unknown
            }
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidDecoding
        }
    }
}
