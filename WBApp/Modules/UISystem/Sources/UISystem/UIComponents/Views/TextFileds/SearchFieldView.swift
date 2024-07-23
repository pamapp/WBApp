//
//  SearchBarView.swift
//  WBApp
//
//  Created by Alina Potapova on 09.06.2024.
//

import SwiftUI

extension SearchFieldView {
    private enum Constants {
        static let verticalPadding: CGFloat = 6
        static let horizontalPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 4
        static let textHeight: CGFloat = 24
    }
}

public struct SearchFieldView: View {
    @Binding var text: String
    
    var icon: String
    var placeholder: String
    
    public init(icon: String, placeholder: String, text: Binding<String>) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Image(icon)
                .foregroundColor(Color.theme.disabled)
                .padding(.vertical, Constants.verticalPadding)
                .padding(.horizontal, Constants.horizontalPadding)
            
            TextField(placeholder, text: $text)
                .frame(height: Constants.textHeight)
                .font(.bodyText1())
                .padding(.vertical, Constants.verticalPadding)
                .submitLabel(.search)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.offWhite)
        .cornerRadius(Constants.cornerRadius)
    }
}
