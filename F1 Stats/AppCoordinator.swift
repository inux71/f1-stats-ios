//
//  AppCoordinator.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject, FullScreenCoverable {
    typealias Item = AppFullScreenCoverableItem
    
    @Published var item: AppFullScreenCoverableItem?
    private(set) var onDismiss: (() -> Void)?
    
    func show(item: AppFullScreenCoverableItem, onDismiss: (() -> Void)? = nil) {
        self.item = item
        self.onDismiss = onDismiss
    }
}
