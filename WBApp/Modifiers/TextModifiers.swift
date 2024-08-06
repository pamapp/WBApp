//
//  TextModifiers.swift
//  WBApp
//
//  Created by Alina Potapova on 05.07.2024.
//

import SwiftUI

struct HeadlineTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.heading2())
            .foregroundColor(Color.theme.active)
            .multilineTextAlignment(.center)
    }
}

struct InfoTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bodyText2())
            .foregroundColor(Color.theme.active)
            .lineSpacing(8)
            .multilineTextAlignment(.center)
    }
}

struct PrimaryButtonTextStyle: ViewModifier {    
    func body(content: Content) -> some View {
        content
            .font(.subheading2())
            .foregroundColor(Color.theme.offWhite)
            .frame(maxWidth: .infinity)
    }
}
