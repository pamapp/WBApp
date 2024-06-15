//
//  ContactDetailView.swift
//  WBApp
//
//  Created by Alina Potapova on 11.06.2024.
//

import SwiftUI

//extension ContactsView {
//    private enum Constants {
//        static let circle
//    }
//}


struct ContactDetailView: View {
    let contact: Contact
    let onBack: () -> Void

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    contactImageView
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
                    
                    SocialLinksView(links: contact.links)
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
                leading: NavigationBarButton(imageName: UI.Icons.back, title: UI.Strings.profile, action: onBack),
                trailing: NavigationBarButton(imageName: UI.Icons.edit, action: {})
            )
        }
    }
    
    @ViewBuilder
    private var contactImageView: some View {
        switch contact.imageName {
        case .some(let imageName):
            Image(imageName)
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .foregroundStyle(Color.theme.offWhite)
        case nil:
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.theme.offWhite)
                .overlay(
                    Image(UI.Icons.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                )
        }
    }
}



#Preview {
    ContactDetailView(contact: .init(name: "Петя",
                                     imageName: "petya",
                                     lastSeen: Date(),
                                     isStory: false,
                                     links: [
                                         SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                                         SocialLink(media: .instagram, url: "https://instagram.com"),
                                         SocialLink(media: .linckedin, url: "https://linkedin.com"),
                                         SocialLink(media: .twitter, url: "https://twitter.com")
                                     ], phoneNumber: "+79284830235"), onBack: {})
}
