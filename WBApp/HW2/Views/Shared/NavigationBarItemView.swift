//
//  NavigationBarItemView.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI

struct NavigationBarItemView: View {
    var imageName: String?
    var title: String?
    var size: CGFloat?
    var action: (() -> Void)?

    var body: some View {
        HStack(spacing: 0) {
            if let imageName, let action {
                Button(action: { action() }, label: {
                    getImage(named: imageName)
                        .foregroundColor(Color.theme.active)
                        .padding(.trailing, 8)
                })
            }
            
            if let title = title {
                Text(title)
                    .font(.subheading1())
                    .padding(.leading, imageName != nil ? 0 : 8)
            }
        }
    }
}

extension NavigationBarItemView {
    @ViewBuilder
    private func getImage(named: String) -> some View {
        switch UIImage(systemName: named) != nil {
        case true:
            Image(systemName: named)
                .font(.system(size: size ?? 14, weight: .semibold))
        case false:
            Image(named)
        }
    }
}
