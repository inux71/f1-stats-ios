//
//  StandingCard.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import SwiftUI

struct StandingCard: View {
    let position: Int
    let title: String
    let subtitle: String
    let points: Int
    
    var body: some View {
        HStack {
            Text("#\(position)")
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                
                Text(subtitle)
                    .font(.caption)
            }
            
            Spacer()
            
            Text("\(points)")
        }
    }
}

#Preview {
    StandingCard(
        position: 1,
        title: "Lewis Hamilton",
        subtitle: "Scuderia Ferrari",
        points: 120
    )
}
