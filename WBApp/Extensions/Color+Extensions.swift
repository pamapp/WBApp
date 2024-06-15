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
    
    //Brand Colors
    let darkColor = Color("color_dark")
    let defaultColor = Color("color_default")
    let offWhite = Color("color_off_white")

    //Neutral
    let white = Color("color_white")
    let active = Color("color_active")
    let disabled = Color("color_disabled")

    //Accent
    let success = Color("color_success")
    
    //Gradient
    let gradient1_1 = Color("color_gradient1_1")
    let gradient1_2 = Color("color_gradient1_2")
    let gradient2_1 = Color("color_gradient2_1")
    let gradient2_2 = Color("color_gradient2_2")
}

