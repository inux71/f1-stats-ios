//
//  NetworkError.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case notFound
    case internalServer
    case invalidResponse
    case invalidDecoding
    case unknown
}
