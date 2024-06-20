//
//  CustomNavigationBar.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String?
    var leadingIcon: String?
    var trailingIcon: String?
    var leadingAction: (() -> ())?
    var trailingAction: (() -> ())?

    var body: some View {
        HStack {
            if let leadingIcon, let leadingAction {
                Button(action: { leadingAction() }, label: {
                    getImage(named: leadingIcon)
                        .foregroundColor(Color.theme.active)
                        .padding(.trailing, 8)
                })
            }
            
            if let title {
                Text(title)
                    .font(.subheading1())
                    .padding(.leading, leadingIcon != nil ? 0 : 8)
            }
            
            Spacer()

            if let trailingIcon, let trailingAction {
                Button(action: { trailingAction() }, label: {
                    getImage(named: trailingIcon)
                        .foregroundColor(Color.theme.active)
                        .padding(.trailing, 8)
                })
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension CustomNavigationBar {
    @ViewBuilder
    private func getImage(named: String) -> some View {
        switch UIImage(systemName: named) != nil {
        case true:
            Image(systemName: named)
                .font(.system(size: 18, weight: .semibold))
        case false:
            Image(named)
        }
    }
}
