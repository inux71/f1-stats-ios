//
//  DriverDetailsView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct DriverDetailsView: View {
    @Environment(\.openURL) private var openURL
    
    @StateObject private var viewModel = DriverDetailsViewModel()
    
    let id: String
    
    var body: some View {
        List {
            if let driver = viewModel.driver {
                Section("Personal details") {
                    Text("Short name: \(driver.shortName)")
                    Text("Number: \(driver.number)")
                    Text("Nationality: \(driver.nationality)")
                    Text("Birthday: \(driver.birthday)")
                }
                
                Section {
                    Button(
                        "Read more",
                        systemImage: "book"
                    ) {
                        if let url = URL(string: driver.url) {
                            openURL(url)
                        } else {
                            viewModel.informationMessage = "Unable to open URL"
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.fetchDriver(id: id)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .toast(
            message: $viewModel.errorMessage,
            systemImage: "xmark.circle",
            role: .error
        )
        .toast(message: $viewModel.informationMessage)
    }
}

#Preview {
    NavigationStack {
        DriverDetailsView(id: "alonso")
    }
}
