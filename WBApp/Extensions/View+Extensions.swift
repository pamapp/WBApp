//
//  View+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 10.06.2024.
//

import SwiftUI

extension View {
    public func tabBarShadow() -> some View {
        self.modifier(TabBarShadow())
    }
}

struct TabBarShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.04), radius: 20)
    }
}
