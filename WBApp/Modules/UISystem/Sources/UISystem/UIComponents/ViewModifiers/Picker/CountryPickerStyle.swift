//
//  CountryPickerStyle.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

public struct CountryPickerStyle: ViewModifier {
    var height: CGFloat
    var flag: String
    var code: String
    
    public init(height: CGFloat, flag: String, code: String) {
        self.height = height
        self.flag = flag
        self.code = code
    }
    
    public func body(content: Content) -> some View {
        Menu {
            content
        } label: {
            HStack {
                Image(flag)
                Text(code)
                    .font(.bodyText1())
                    .accentColor(Color.theme.disabled)
            }
        }
        .frame(height: height)
        .padding(.horizontal, 8)
        .background(Color.theme.offWhite)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

