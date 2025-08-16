//
//  MainViewModel.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 16/08/2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var selectedTab: MainViewTab = .standings
}
