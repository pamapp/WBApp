//
//  ContactsScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

extension ContactsScreen {
    private enum Constants {
        static let dragThreshold: CGFloat = 70.0
        static let animationDuration: CGFloat = 0.25
        static let gestureAnimationDuration: CGFloat = 0.12
    }
}

struct ContactsScreen: View {
    @EnvironmentObject var router: Router
    @State private var containerSize: CGSize = .zero
    @State private var offsets: (detailView: CGFloat, contactsView: CGFloat) = (0, 0)

    var body: some View {
        ZStack {
            ContactsListView(onContactTap: showContactDetail)
                .containerSizeGetter($containerSize)
                .offset(x: offsets.contactsView)
                .zIndex(0)
            
            if let contact = router.selectedContact {
                ContactDetailView(contact: contact, onBack: hideContactDetail, containerSize: containerSize)
                    .offset(x: offsets.detailView)
                    .transition(.move(edge: .trailing))
                    .gesture(dragGesture)
                    .onAppear {
                        offsets = (detailView: 0, contactsView: -(containerSize.width * 0.3))
                    }
                    .zIndex(1)
            }
        }
    }

    private func showContactDetail(contact: Contact) {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            offsets = (detailView: 0, contactsView: -(containerSize.width * 0.3))
            router.navigate(to: .contactDetail, contact: contact)
        }
    }

    private func hideContactDetail() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            offsets = (detailView: containerSize.width, contactsView: 0)
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
                let contactsViewOffset = containerSize.width * 0.3
                
                if translation > 0 {
                    let progress = min(max(translation / UIScreen.main.bounds.width, 0), 1)
                    offsets.detailView = translation
                    offsets.contactsView = -contactsViewOffset + progress * contactsViewOffset
                } else {
                    offsets.detailView = 0
                    offsets.contactsView = router.selectedRoute == .contacts ? 0 : -contactsViewOffset
                }
            }
            .onEnded { value in
                value.translation.width > Constants.dragThreshold ?
                    withAnimation(.linear(duration: Constants.gestureAnimationDuration)) {
                        offsets = (detailView: containerSize.width, contactsView: 0)
                        router.selectedContact = nil
                        router.navigate(to: .contacts)
                    }
                :
                    withAnimation(.easeInOut(duration: Constants.gestureAnimationDuration)) {
                        offsets.detailView = 0
                    }
            }
    }
}
