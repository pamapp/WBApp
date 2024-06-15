//
//  ContactDetailView.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contact
    let onBack: () -> Void

    var body: some View {
        NavigationStack {
            
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.theme.offWhite)
                        .overlay(
                            Image("avatar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 90)
                        )
                        .padding(.top, geo.adaptiveVerticalPadding(46))
                    
                    Text(contact.name)
                        .font(.subheading1())
                        .foregroundColor(Color.theme.active)
                        .padding(.top, geo.adaptiveVerticalPadding(20))
                    
                    if let phone = contact.phoneNumber {
                        Text(phone)
                            .font(.subheading2())
                            .foregroundColor(Color.theme.disabled)
                            .padding(.top, geo.adaptiveVerticalPadding(4))
                    }
                    
                    HStack(spacing: 12) {
                        ForEach(contact.links, id: \.self) { link in
                            socialLinkButton(link: link)
                        }
                    }
                    .padding(.horizontal, 26)
                    .padding(.top, geo.adaptiveVerticalPadding(40))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.theme.white.ignoresSafeArea(.all))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: NavigationBarButton(imageName: "chevron.left", title: "Профиль", action: onBack),
                trailing: NavigationBarButton(imageName: "edit", action: {})
            )
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
