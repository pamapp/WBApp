//
//  TextFieldStyles.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

struct SimpleTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool
    var height: CGFloat

    func _body(configuration: TextField<Self._Label>) -> some View {
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


struct PinFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .accentColor(.clear)
            .foregroundColor(.clear)
            .keyboardType(.numberPad)
    }
}
