//
//  Toast.swift
//  F1 Stats
//
//  Created by Kacper Grabiec on 17/08/2025.
//

import Foundation
import SwiftUI

fileprivate struct Toast: ViewModifier {
    @Binding var message: String?
    let systemImage: String
    let role: ToastRole
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let message = message {
                    Label(
                        message,
                        systemImage: systemImage
                    )
                    .padding(.vertical, 8)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    .foregroundStyle(Color.white)
                    .background(role == .information ? Color.accentColor : Color.red)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                self.message = nil
                            }
                        }
                    }
                }
            }
            .animation(
                .easeInOut,
                value: message
            )
    }
}

extension View {
    func toast(
        message: Binding<String?>,
        systemImage: String = "info.circle",
        role: ToastRole = .information,
        duration: TimeInterval = 2.0
    ) -> some View {
        modifier(Toast(
            message: message,
            systemImage: systemImage,
            role: role,
            duration: duration
        ))
    }
}
