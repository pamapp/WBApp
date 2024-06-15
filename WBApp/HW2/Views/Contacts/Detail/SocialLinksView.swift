//
//  SocialLinksView.swift
//  WBApp
//
//  Created by Alina Potapova on 15.06.2024.
//

import SwiftUI

struct SocialLinksView: View {
    let links: [SocialLink]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(links, id: \.self) { link in
                socialLinkButton(link: link)
            }
        }
    }

    private func socialLinkButton(link: SocialLink) -> some View {
        Link(destination: link.url) {
            Capsule()
                .stroke(Color.theme.defaultColor, lineWidth: 1.6)
                .frame(height: 40)
                .overlay(
                    link.media.image
                        .resizable()
                        .frame(width: 20, height: 20)
                )
        }
    }
}
