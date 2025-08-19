//
//  TeamDetailsView.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct TeamDetailsView: View {
    @Environment(\.openURL) private var openURL
    
    @StateObject private var viewModel = TeamDetailsViewModel()
    
    let id: String
    
    var body: some View {
        List {
            if let team = viewModel.team {
                Section("Team details") {
                    Text("Nationality \(team.teamNationality)")
                    Text("Constructors championships: \(team.constructorsChampionships)")
                    Text("Drivers championships: \(team.driversChampionships)")
                    Text("First appeareance: \(team.firstAppeareance)")
                }
                
                Section {
                    Button(
                        "Read more",
                        systemImage: "book"
                    ) {
                        if let url = URL(string: team.url) {
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
            viewModel.fetchTeam(id: id)
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
        TeamDetailsView(id: "mclaren")
    }
}
