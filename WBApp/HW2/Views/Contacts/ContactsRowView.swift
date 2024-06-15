//
//  ContactRowView.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

struct ContactRowView: View {
    let contact: Contact
    
    var body: some View {
        HStack(spacing: 12) {
            avatarView
            contactInfoView
            Spacer()
        }
        .background(Color.theme.white)
    }
    
}

extension ContactRowView {
    private var avatarView: some View {
        ZStack {
            avatarImage
            storyBorder
            onlineIndicator
        }
    }
    
    private var storyBorder: some View {
        contact.isStory ?
        AnyView(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    contact.imageName != nil ? LinearGradient.blueGradient : LinearGradient.purpleGradient,
                    lineWidth: 2
                )
                .frame(width: 54, height: 54)
        ) :
        AnyView(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color.clear,
                    lineWidth: 2
                )
                .frame(width: 54, height: 54)
        )
    }
    
    private var avatarImage: some View {
        contact.imageName != nil ?
            AnyView(
                Image(contact.imageName!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            ) :
            AnyView(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.theme.defaultColor)
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(contact.name.initials)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                    )
            )
    }
    
    private var onlineIndicator: some View {
        Group {
            if contact.isOnline {
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Circle()
                            .fill(Color.green)
                            .frame(width: 12, height: 12)
                    )
                    .frame(width: 15, height: 15)
                    .offset(x: 20, y: -20)
            }
        }
    }
    
    private var contactInfoView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(contact.name)
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
                .frame(height: 24)
            
            Text(contact.laseSeenText)
                .font(.metadata1())
                .foregroundColor(Color.theme.disabled)
                .frame(height: 20)
            
            Spacer()
        }
        .frame(height: 56)
    }
}


//#Preview {
//    VStack {
//        ContactRowView(contact: Contact(name: "Анастасия Иванова",
//                                        lastSeen: Date(),
//                                        isStory: true,
//                                        links: [
//                                            SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
//                                            SocialLink(media: .instagram, url: "https://instagram.com"),
//                                            SocialLink(media: .linckedin, url: "https://linkedin.com"),
//                                            SocialLink(media: .twitter, url: "https://twitter.com"),
//                                        ],
//                                        phoneNumber: "+7 999 999-99-99"))
//
//        ContactRowView(contact: Contact(name: "Анастасия Иванова",
//                                        imageName: "nastya",
//                                        lastSeen: Date(),
//                                        isStory: false,
//                                        links: [
//                                            SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
//                                            SocialLink(media: .instagram, url: "https://instagram.com"),
//                                            SocialLink(media: .linckedin, url: "https://linkedin.com"),
//                                            SocialLink(media: .twitter, url: "https://twitter.com"),
//                                        ],
//                                        phoneNumber: "+7 999 999-99-99"))
//    }
//}


