//
//  InfoTextStyle.swift
//
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

public struct InfoTextStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(.bodyText2())
            .foregroundColor(Color.theme.active)
            .lineSpacing(8)
            .multilineTextAlignment(.center)
    }
}

