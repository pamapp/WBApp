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
    let danger = Color("color_danger")

    //Gradient
    let gradient1_1 = Color("color_gradient1_1")
    let gradient1_2 = Color("color_gradient1_2")
    let gradient2_1 = Color("color_gradient2_1")
    let gradient2_2 = Color("color_gradient2_2")

    //HW7
    let c1 = Color("c1")
    let c2 = Color("c2")
    let c3 = Color("c3")
    let c4 = Color("c4")
    let c5 = Color("c5")
    let c6 = Color("c6")
    let c7 = Color("c7")
    let c8 = Color("c8")
}

extension ColorTheme {
    var hw7Colors: [Color] {
        return [c1, c2, c3, c4, c5, c6, c7]
    }
    
    var randomColor: Color {
        return hw7Colors.randomElement()!
    }
}

extension LinearGradient {
    static var blueGradient = LinearGradient(
        gradient: Gradient(colors: [Color.theme.gradient1_1, Color.theme.gradient1_2]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static var purpleGradient = LinearGradient(
        gradient: Gradient(colors: [Color.theme.gradient2_1, Color.theme.gradient2_2]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static var clearGradient = LinearGradient(
        gradient: Gradient(colors: [Color.clear]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
