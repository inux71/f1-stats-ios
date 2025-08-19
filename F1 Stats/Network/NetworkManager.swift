//
//  NetworkManager.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Decodable>(from api: API) async throws -> T {
        guard let url = URL(string: "\(NetworkConfiguration.BaseURL)/\(api.path)") else {
            throw NetworkError.invalidURL
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
            
            return try decoder.decode(
                T.self,
                from: data
            )
        } catch {
            throw NetworkError.invalidDecoding
        }
    }
}
