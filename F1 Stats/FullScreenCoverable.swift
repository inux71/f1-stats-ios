//
//  FullScreenCoverable.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import Foundation

protocol FullScreenCoverable {
    associatedtype Item: Identifiable
    
    var item: Item? { get }
    var onDismiss: (() -> Void)? { get }
    
    func show(item: Item, onDismiss: (() -> Void)?)
    func dismiss()
}
