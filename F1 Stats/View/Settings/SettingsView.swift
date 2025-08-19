//
//  SettingsView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(
                        "Close",
                        role: .destructive
                    ) {
                        appCoordinator.dismiss()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(AppCoordinator())
}
