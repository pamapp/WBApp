//
//  HeadlineTextStyle.swift
//
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

public struct HeadlineTextStyle: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(.heading2())
            .foregroundColor(Color.theme.active)
            .multilineTextAlignment(.center)
    }
}
