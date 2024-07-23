//
//  View+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 10.06.2024.
//

import SwiftUI
import UISystem

extension View {
    public func tabBarShadow() -> some View {
        self.modifier(TabBarShadow())
    }
}

extension View {
    func containerSizeGetter(_ size: Binding<CGSize>) -> some View {
        self.modifier(ContainerSizeModifier(size: size))
    }
}

extension View {
    func countryPickerStyle(height: CGFloat, flag: String, code: String) -> some View {
        self.modifier(CountryPickerStyle(height: height, flag: flag, code: code))
    }
}

extension View {
    func headlineTextStyle() -> some View {
        self.modifier(HeadlineTextStyle())
    }
    
    func infoTextStyle() -> some View {
        self.modifier(InfoTextStyle())
    }
    
    func primaryButtonTextStyle() -> some View {
        self.modifier(PrimaryButtonTextStyle())
    }
    
    func metaTextStyle(color: Color) -> some View {
        self.modifier(MetaTextStyle(color: color))
    }
}
