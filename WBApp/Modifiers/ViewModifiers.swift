//
//  ViewModifiers.swift
//  WBApp
//
//  Created by Alina Potapova on 15.06.2024.
//

import SwiftUI

struct TabBarShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.04), radius: 20)
    }
}
