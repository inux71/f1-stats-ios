//
//  Navigable.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation
import SwiftUI

protocol Navigable {
    associatedtype Destination: Hashable
    
    var path: NavigationPath { get }
    
    func navigate(to destination: Destination)
    func navigateBack()
}
