//
//  ContactsView.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

extension ContactsView {
    private enum Constants {
        static let contactsViewOffset: CGFloat = UI.screenWidth * 0.3
        static let dragThreshold: CGFloat = 70.0
    }
}

struct ContactsView: View {
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
                            offsets.detailView = UI.screenWidth
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
            router.navigate(to: .contacts)
        }
    }
}

extension ContactsView {
    private var dragGesture: some Gesture {
            DragGesture()
                .onChanged { value in
                    let translation = value.translation.width
                    if translation > 0 {
                        offsets.detailView = translation
                        let progress = min(max(offsets.detailView / UI.screenWidth, 0), 1)
                        offsets.contactsView = -Constants.contactsViewOffset + progress * Constants.contactsViewOffset
                    }
                }
                .onEnded { value in
                    if value.translation.width > Constants.dragThreshold {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            router.selectedContact = nil
                            offsets.contactsView = 0
                        }
                    }

                    withAnimation(.easeInOut(duration: 0.1)) {
                        offsets.detailView = 0
                    }
                }
        }
}
