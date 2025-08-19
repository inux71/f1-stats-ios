//
//  Card.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 18/08/2025.
//

import SwiftUI

struct Card: View {
    let leadingText: String?
    let title: String
    let subtitle: String?
    let trailingText: String?
    
    init(
        leadingText: String? = nil,
        title: String,
        subtitle: String? = nil,
        trailingText: String? = nil
    ) {
        self.leadingText = leadingText
        self.title = title
        self.subtitle = subtitle
        self.trailingText = trailingText
    }
    
    var body: some View {
        HStack {
            if let leadingText {
                Text(leadingText)
                    .fontWeight(.bold)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            if let trailingText {
                Text(trailingText)
            }
        }
    }
}

#Preview {
    Card(
        leadingText: "#9",
        title: "Robert Lewandowski",
        subtitle: "FC Barcelona",
        trailingText: "POL"
    )
}
