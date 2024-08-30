//
//  PrimaryButtonTextStyle.swift
//
//
//  Created by Alina Potapova on 05.07.2024.
//

import SwiftUI

public struct PrimaryButtonTextStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(.subheading2())
            .foregroundColor(Color.theme.offWhite)
            .frame(maxWidth: .infinity)
    }
}
