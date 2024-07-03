//
//  ContactsScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

extension ContactsScreen {
    private enum Constants {
        static let contactsViewOffset: CGFloat = UIScreen.main.bounds.width * 0.3
        static let dragThreshold: CGFloat = 70.0
    }
}

struct ContactsScreen: View {
    @EnvironmentObject var router: Router
    
    @State private var offsets: (detailView: CGFloat, contactsView: CGFloat) = (0, 0)
    
    var body: some View {
        ZStack {
            ContactsListView(onContactTap: showContactDetail)
                .offset(x: offsets.contactsView)
                .zIndex(0)

            if let contact = router.selectedContact {
                ContactDetailView(contact: contact, onBack: hideContactDetail)
                    .offset(x: offsets.detailView)
                    .transition(.move(edge: .trailing))
                    .gesture(dragGesture)
                    .onChange(of: router.selectedContact) { newValue in
                        if newValue == nil {
                            offsets.detailView = UIScreen.main.bounds.width
                        }
                    }
                    .zIndex(1)
            }
        }
    }

    private func showContactDetail(contact: Contact) {
        withAnimation(.easeInOut(duration: 0.25)) {
            offsets.contactsView = -Constants.contactsViewOffset
            router.navigate(to: .contactDetail, contact: contact)
        }
    }

    private func hideContactDetail() {
        withAnimation(.easeInOut(duration: 0.25)) {
            offsets.contactsView = 0
            router.selectedContact = nil
            router.navigate(to: .contacts)
        }
    }
}

extension ContactsScreen {
    private var dragGesture: some Gesture {
            DragGesture()
                .onChanged { value in
                    let translation = value.translation.width
                    if translation > 0 {
                        offsets.detailView = translation
                        let progress = min(max(offsets.detailView / UIScreen.main.bounds.width, 0), 1)
                        offsets.contactsView = -Constants.contactsViewOffset + progress * Constants.contactsViewOffset
                    }
                }
                .onEnded { value in
                    if value.translation.width > Constants.dragThreshold {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            router.selectedContact = nil
                            router.navigate(to: .contacts)
                            offsets.contactsView = 0
                        }
                    }

                    withAnimation(.easeInOut(duration: 0.1)) {
                        offsets.detailView = 0
                    }
                }
        }
}
