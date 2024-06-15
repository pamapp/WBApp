//
//  SocialLinksView.swift
//  WBApp
//
//  Created by Alina Potapova on 15.06.2024.
//

import SwiftUI

extension SocialLinksView {
    private enum Constants {
        static let linksSpacing: CGFloat = 12
        static let linkStrokeWidth: CGFloat = 1.6
        static let linkHeight: CGFloat = 40
        static let linkImageSize: CGFloat = 20
    }
}

struct SocialLinksView: View {
    let links: [SocialLink]

    var body: some View {
        HStack(spacing: Constants.linksSpacing) {
            ForEach(links, id: \.self) { link in
                socialLinkButton(link: link)
            }
        }
    }

    private func socialLinkButton(link: SocialLink) -> some View {
        Link(destination: link.url) {
            Capsule()
                .stroke(Color.theme.defaultColor, lineWidth: Constants.linkStrokeWidth)
                .frame(height: Constants.linkHeight)
                .overlay(
                    link.media.image
                        .resizable()
                        .frame(width: Constants.linkImageSize, height: Constants.linkImageSize)
                )
        }
    }
}
