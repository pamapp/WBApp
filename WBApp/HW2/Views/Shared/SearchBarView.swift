//
//  SearchBarView.swift
//  WBApp
//
//  Created by Alina Potapova on 09.06.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 0) {
            Image(UI.Icons.search)
                .foregroundColor(Color.theme.disabled)
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
            
            TextField(UI.Strings.search, text: $text)
                .frame(height: 24)
                .font(.bodyText1())
                .padding(.vertical, 6)
                .submitLabel(.search)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.offWhite)
        .cornerRadius(4)
    }
}
