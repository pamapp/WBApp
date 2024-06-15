//
//  NavigationBarSideView.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI

struct NavigationBarButton: View {
    var imageName: String?
    var title: String?
    var size: CGFloat?
    let action: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            if let imageName {
                Button(action: { action() }, label: {
                    getImage(named: imageName)
                        .foregroundColor(Color.theme.active)
                        .padding(.trailing, 8)
                })
            }
            
            if let title = title {
                NavigationBarTitle(title: title)
            }
        }
    }

    @ViewBuilder
    private func getImage(named: String) -> some View {
        if UIImage(systemName: named) != nil {
            Image(systemName: named)
                .font(.system(size: size ?? 14, weight: .semibold))
        } else {
            Image(named)
        }
    }
}

struct NavigationBarTitle: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.subheading1())
    }
}
