//
//  Font+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

extension Font {
    static func headline1(_ size: CGFloat = 32) -> Font {
        .system(size: size, weight: .bold, design: .none)
    }
    
    static func headline2(_ size: CGFloat = 24) -> Font {
        .system(size: size, weight: .bold, design: .none)
    }
    
    static func subheadline1(_ size: CGFloat = 18) -> Font {
        .system(size: size, weight: .semibold, design: .none)
    }
    
    static func subheadline2(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .semibold, design: .none)
    }
    
    static func bodyText1(_ size: CGFloat = 14) -> Font {
        .system(size: size, weight: .semibold, design: .none)
    }
    
    static func bodyText2(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .none)
    }
    
    static func metadata1(_ size: CGFloat = 12) -> Font {
        .system(size: size, weight: .regular, design: .none)
    }
    
    static func metadata2(_ size: CGFloat = 10) -> Font {
        .system(size: size, weight: .regular, design: .none)
    }
    
    static func metadata3(_ size: CGFloat = 10) -> Font {
        .system(size: size, weight: .semibold, design: .none)
    }
}
