//
//  MetaTextStyle.swift
//
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

public struct MetaTextStyle: ViewModifier {
    var color: Color
    
    public init(color: Color) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.metadata1())
            .foregroundColor(color)
    }
}
