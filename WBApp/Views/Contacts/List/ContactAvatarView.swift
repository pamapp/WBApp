//
//  ContactAvatarView.swift
//  WBApp
//
//  Created by Alina Potapova on 15.06.2024.
//

import SwiftUI

extension ContactAvatarView {
    private enum Constants {
        static let avatarSize: CGFloat = 48
        static let imageSize: CGFloat = 54
        static let strokeCornerRadius: CGFloat = 16
        static let strokeBorderWidth: CGFloat = 2
        static let onlineIndicatorSize: CGFloat = 15
        static let onlineIndicatorOffset: CGFloat = 20
    }
}

struct ContactAvatarView: View {
    @State var isOnline: Bool
    @State var isStory: Bool
    @State var initials: String
    @State var imageName: String?

    var body: some View {
        ZStack {
            avatarImage
            storyBorder
            onlineIndicator
        }
    }
}

extension ContactAvatarView {
    @ViewBuilder
    private var storyBorder: some View {
        switch isStory {
        case true:
            RoundedRectangle(cornerRadius: Constants.strokeCornerRadius)
                .stroke(
                    imageName != nil ? LinearGradient.blueGradient : LinearGradient.purpleGradient,
                    lineWidth: Constants.strokeBorderWidth
                )
                .frame(width: Constants.imageSize, height: Constants.imageSize)
        case false:
            RoundedRectangle(cornerRadius: Constants.strokeCornerRadius)
                .stroke(
                    Color.clear,
                    lineWidth: Constants.strokeBorderWidth
                )
                .frame(width: Constants.imageSize, height: Constants.imageSize)
        }
    }
    
    @ViewBuilder
    private var avatarImage: some View {
        switch imageName {
        case .some(let imageName):
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                .clipShape(RoundedRectangle(cornerRadius: Constants.strokeCornerRadius - 2))
        case nil:
            RoundedRectangle(cornerRadius: Constants.strokeCornerRadius - 2)
                .fill(Color.theme.defaultColor)
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                .overlay(
                    Text(initials)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                )
        }
    }
    
    @ViewBuilder
    private var onlineIndicator: some View {
        switch isOnline {
        case true:
            Circle()
                .fill(Color.white)
                .overlay(
                    Circle()
                        .fill(Color.green)
                        .frame(width: Constants.onlineIndicatorSize, height: Constants.onlineIndicatorSize)
                )
                .frame(width: Constants.onlineIndicatorSize + 3, height: Constants.onlineIndicatorSize + 3)
                .offset(x: Constants.onlineIndicatorOffset, y: -Constants.onlineIndicatorOffset)
        case false:
            EmptyView()
        }
    }
}
