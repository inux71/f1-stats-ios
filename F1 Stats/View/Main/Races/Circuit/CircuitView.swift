//
//  CircuitView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct CircuitView: View {
    @Environment(\.openURL) private var openURL
    
    @StateObject private var viewModel = CircuitViewModel()
    
    let id: String
    
    var body: some View {
        List {
            if let circuit = viewModel.circuit {
                Section("Circuit details") {
                    Text("Country: \(circuit.country)")
                    Text("City: \(circuit.city)")
                    Text("Length: \(circuit.circuitLength) m")
                    Text("Corners: \(circuit.numberOfCorners)")
                }
                
                Section {
                    Button(
                        "Read more",
                        systemImage: "book"
                    ) {
                        if let url = URL(string: circuit.url) {
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
            viewModel.fetchCircuit(id: id)
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
        CircuitView(id: "monza")
    }
}
