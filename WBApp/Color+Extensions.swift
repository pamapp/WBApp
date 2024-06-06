//
//  Color+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let offWhite = Color("Off-white")
    let active = Color("Active")
    let darkColor = Color("Dark")
    let defaultColor = Color("Default")
}
