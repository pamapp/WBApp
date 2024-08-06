//
//  PickerModifiers.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

struct CountryPickerStyle: ViewModifier {
    var containerSize: CGSize
    var selectedCountry: String

    func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                Image(CountryCodesProvider.flag(for: selectedCountry))
                Text(CountryCodesProvider.phoneCode(for: selectedCountry))
                    .font(.bodyText1())
                    .accentColor(Color.theme.disabled)
            }
        }
        .frame(height: containerSize.adaptiveVerticalPadding(36))
        .padding(.horizontal, 8)
        .background(Color.theme.offWhite)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
