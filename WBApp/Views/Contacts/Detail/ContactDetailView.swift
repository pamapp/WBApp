//
//  ContactDetailView.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI
import UISystem

extension ContactDetailView {
    private enum Constants {
        static let circleSize: CGFloat = 200
        static let iconHeight: CGFloat = 90
        static let imageTopPadding: CGFloat = 46
        static let nameTopPadding: CGFloat = 20
        static let phoneTopPadding: CGFloat = 4
        static let linksTopPadding: CGFloat = 40
        static let linksHorizontalPadding: CGFloat = 26
    }
}

struct ContactDetailView: View {
    let contact: Contact
    let onBack: () -> Void
    let containerSize: CGSize
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(
                title: UI.Strings.profile,
                leadingIcon: UI.Icons.back,
                trailingIcon: UI.Icons.edit,
                leadingAction: onBack,
                trailingAction: {}
            )

            contactImageView
                .padding(.top, containerSize.adaptiveVerticalPadding(Constants.imageTopPadding))

            contactNameView
                .padding(.top, containerSize.adaptiveVerticalPadding(Constants.nameTopPadding))
            
            contactPhoneView
                .padding(.top, containerSize.adaptiveVerticalPadding(Constants.phoneTopPadding))
            
            SocialLinksView(links: contact.links)
                .padding(.top, containerSize.adaptiveVerticalPadding(Constants.linksTopPadding))
                .padding(.horizontal, Constants.linksHorizontalPadding)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.theme.white.ignoresSafeArea(.all))
    }
}

extension ContactDetailView {
    private var contactNameView: some View {
        Text(contact.name)
            .font(.subheading1())
            .foregroundColor(Color.theme.active)
    }
    
    @ViewBuilder
    private var contactPhoneView: some View {
        if let phone = contact.phoneNumber {
            Text(phone)
                .font(.subheading2())
                .foregroundColor(Color.theme.disabled)
        }
    }
    
    @ViewBuilder
    private var contactImageView: some View {
        switch contact.imageName {
        case .some(let imageName):
            Image(imageName)
                .resizable()
                .frame(width: Constants.circleSize, height: Constants.circleSize)
                .clipShape(Circle())
        case nil:
            Circle()
                .frame(width: Constants.circleSize, height: Constants.circleSize)
                .foregroundStyle(Color.theme.offWhite)
                .overlay(
                    Image(UI.Icons.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.iconHeight)
                )
        }
    }
}
