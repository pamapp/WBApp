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
    
    @State private var selectedContact: Contact? = nil
    @State private var offsets: (detailView: CGFloat, contactsView: CGFloat) = (0, 0)
    
    var body: some View {
        ZStack {
            ContactsListView(onContactTap: showContactDetail)
                .offset(x: offsets.contactsView)
                .zIndex(0)

            if let contact = selectedContact {
                ContactDetailView(contact: contact, onBack: hideContactDetail)
                    .offset(x: offsets.detailView)
                    .transition(.move(edge: .trailing))
                    .gesture(dragGesture)
                    .onChange(of: selectedContact) { newValue in
                        if newValue == nil {
                            offsets.detailView = UI.screenWidth
                        }
                    }
                    .zIndex(1)
            }
        }
        .onOpenURL { url in
            handleDeepLink(url: url)
        }
    }

    private func showContactDetail(contact: Contact) {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedContact = contact
            offsets.contactsView = -Constants.contactsViewOffset
            router.navigate(to: .contactDetail(contact))
        }
    }

    private func hideContactDetail() {
        withAnimation(.easeInOut(duration: 0.25)) {
            selectedContact = nil
            offsets.contactsView = 0
            router.navigate(to: .contacts)
        }
    }

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
                        selectedContact = nil
                        offsets.contactsView = 0
                    }
                }

                withAnimation(.easeInOut(duration: 0.1)) {
                    offsets.detailView = 0
                }
            }
    }
    
    private func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        
        switch components.host {
        case "contactdetails":
            if let id = components.queryItems?.first(where: { $0.name == "id" })?.value {
                if let contactId = UUID(uuidString: id) {
                    // я нажимаю на виджете на контакта (Анастасия Иванова) id которого должен совпадать с первым, но эти id разные
                    print(contactId)
                    print(SharedData.shared.contacts.first?.id)
                    
                    if let contact = SharedData.shared.contacts.first(where: { $0.id == contactId }) {
                        selectedContact = contact
                    }
                }
            }
        default:
            break
        }
    }
}
