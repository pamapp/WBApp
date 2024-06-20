//
//  ContactRowView.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

extension ContactRowView {
    private enum Constants {
        static let rowSpacing: CGFloat = 20
        static let infoSpacing: CGFloat = 20

        static let nameHeight: CGFloat = 24
        static let lastSeenHeight: CGFloat = 20
        static let infoHeight: CGFloat = 56
    }
}

struct ContactRowView: View {
    @State var contact: Contact
    
    var body: some View {
        HStack(spacing: 12) {
            ContactAvatarView(isOnline: contact.isOnline,
                              isStory: contact.isStory,
                              initials: contact.name.initials,
                              imageName: contact.imageName)
            contactInfoView
            Spacer()
        }
        .background(Color.theme.white)
    }
}

extension ContactRowView {
    private var contactInfoView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(contact.name)
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
                .frame(height: Constants.nameHeight)
            
            Text(contact.laseSeenText)
                .font(.metadata1())
                .foregroundColor(Color.theme.disabled)
                .frame(height: Constants.lastSeenHeight)
            
            Spacer()
        }
        .frame(height: Constants.infoHeight)
    }
}
