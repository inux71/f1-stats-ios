//
//  DriverChampionshipDriver.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

struct DriverChampionshipDriver: Decodable {
    let name: String
    let surname: String
    let nationality: String
    let birthday: String
    let number: Int
    let shortName: String
    let url: String
}
