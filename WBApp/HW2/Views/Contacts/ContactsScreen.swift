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
    @State private var timer: Timer?
    @State private var offsets: (detailView: CGFloat, contactsView: CGFloat) = (UIScreen.main.bounds.width, 0)
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ContactsListView(onContactTap: showContactDetail(geo: geo))
                    .offset(x: offsets.contactsView)
                    .zIndex(0)
                
                if let contact = router.selectedContact {
                    ContactDetailView(contact: contact, onBack: hideContactDetail(geo: geo))
                        .offset(x: offsets.detailView)
                        .transition(.move(edge: .trailing))
                        .gesture(dragGesture(geo: geo))
                        .onChange(of: router.selectedContact) { newValue in
                            if newValue == nil {
                                offsets.detailView = UIScreen.main.bounds.width
                            }
                        }
                        .zIndex(1)
                }
            }
        }
    }

    private func showContactDetail(geo: GeometryProxy) -> (Contact) -> Void {
        return { contact in
            withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                offsets.contactsView = -(geo.size.width * 0.3)
                offsets.detailView = 0
                router.navigate(to: .contactDetail, contact: contact)
            }
        }
    }

    private func hideContactDetail(geo: GeometryProxy) -> () -> Void {
        return {
            withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                offsets.contactsView = 0
                offsets.detailView = geo.size.width
                router.selectedContact = nil
                router.navigate(to: .contacts)
            }
        }
    }
}

extension ContactsScreen {
    private func dragGesture(geo: GeometryProxy) -> some Gesture {
        DragGesture()
            .onChanged { value in
                let translation = value.translation.width
                let contactsViewOffset = geo.size.width * 0.3
                
                if translation > 0 {
                    offsets.detailView = translation
                    let progress = min(max(offsets.detailView / UIScreen.main.bounds.width, 0), 1)
                    offsets.contactsView = -contactsViewOffset + progress * contactsViewOffset
                } else {
                    offsets.detailView = 0
                    offsets.contactsView = router.selectedRoute == .contacts ? 0 : -contactsViewOffset
                }
            }
            .onEnded { value in
                value.translation.width > Constants.dragThreshold ?
                    withAnimation(.linear(duration: Constants.gestureAnimationDuration)) {
                        offsets.contactsView = 0
                        offsets.detailView = UIScreen.main.bounds.width
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
