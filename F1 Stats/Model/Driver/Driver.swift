//
//  Driver.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import Foundation

struct Driver: Decodable {
    let driverId: String
    let name: String
    let surname: String
    let nationality: String
    let birthday: String
    let number: Int
    let shortName: String
    let url: String
}
