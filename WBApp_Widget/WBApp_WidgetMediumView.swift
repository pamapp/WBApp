//
//  WBApp_WidgetMediumView.swift
//  WBApp
//
//  Created by Alina Potapova on 17.06.2024.
//
import WidgetKit
import SwiftUI

struct WBApp_WidgetMediumView: View {
    var entry: Provider.Entry

    var body: some View {
        Grid {
            HStack() {
                ForEach(entry.contactToDisplay.prefix(4)) { contact in
                    Link(destination: URL(string: "myapp://contactdetails?name=\(contact.name)")!) {
                        contactImageView(imageName: contact.imageName, initials: contact.name.initials)
                    }        
                    .frame(maxWidth: .infinity)
                }
            }
            HStack {
                ForEach(entry.contactToDisplay.dropFirst(4).prefix(4)) { contact in
                    Link(destination: URL(string: "myapp://contactdetails?name=\(contact.name)")!) {
                        contactImageView(imageName: contact.imageName, initials: contact.name.initials)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    @ViewBuilder
    private func contactImageView(imageName: String?, initials: String) -> some View {
        switch imageName {
        case .some(let imageName):
            Image(imageName)
                .resizable()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
        case nil:
            Circle()
                .frame(width: 64, height: 64)
                .foregroundStyle(Color.theme.defaultColor)
                .overlay(
                    Text(initials)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                )
        }
    }
}

#Preview(as: .systemMedium) {
    WBApp_Widget()
} timeline: {
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts.prefix(3)), currentContactIndex: 0)
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts.prefix(6)), currentContactIndex: 0)
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts.prefix(8)), currentContactIndex: 0)
}

