//
//  ButtonStyles.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Capsule()
                    .foregroundColor(configuration.isPressed ? Color.dark : Color.default)
            )
    }
}
