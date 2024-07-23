//
//  Color+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

public extension Color {
    static let theme = ColorTheme()
}

public struct ColorTheme {
    
    //Brand Colors
    public let darkColor = Color("color_dark")
    public let defaultColor = Color("color_default")
    public let offWhite = Color("color_off_white")
    
    //Neutral
    public let white = Color("color_white")
    public let active = Color("color_active")
    public let disabled = Color("color_disabled")
    
    //Accent
    public let success = Color("color_success")
    public let danger = Color("color_danger")

    //Gradient
    public let gradient1_1 = Color("color_gradient1_1")
    public let gradient1_2 = Color("color_gradient1_2")
    public let gradient2_1 = Color("color_gradient2_1")
    public let gradient2_2 = Color("color_gradient2_2")

    //HW7
    public let c1 = Color("c1")
    public let c2 = Color("c2")
    public let c3 = Color("c3")
    public let c4 = Color("c4")
    public let c5 = Color("c5")
    public let c6 = Color("c6")
    public let c7 = Color("c7")
    public let c8 = Color("c8")
}

extension ColorTheme {
    public var hw7Colors: [Color] {
        return [c1, c2, c3, c4, c5, c6, c7]
    }
    
    public var randomColor: Color {
        return hw7Colors.randomElement()!
    }
}

public extension LinearGradient {
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
