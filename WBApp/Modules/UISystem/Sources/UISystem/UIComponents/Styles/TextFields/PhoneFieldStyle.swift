//
//  PhoneFieldStyle.swift
//  WBApp
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

public struct PhoneFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool
    var height: CGFloat
    
    public init(height: CGFloat) {
        self.height = height
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .keyboardType(.numberPad)
            .font(.bodyText1())
            .foregroundColor(Color.theme.active)
            .padding(.horizontal)
            .frame(height: height)
            .background(Color.theme.offWhite)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
