//
//  WBApp_WidgetSmallView.swift
//  WBApp
//
//  Created by Alina Potapova on 17.06.2024.
//
import WidgetKit

import SwiftUI

struct WBApp_WidgetSmallView: View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geo in
            VStack {     
                contactImageView
            
                Text(entry.contactToDisplay[entry.currentContactIndex].name)
                    .font(.bodyText1())
                
                Spacer()
                
                HStack {
                    Button(intent: ChangeContactIntent(index: (entry.currentContactIndex - 1 + entry.contactToDisplay.count) % entry.contactToDisplay.count)) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.theme.offWhite)
                    }
                    .frame(width: geo.size.width / 2 - 4, height: 30)
                    .background(
                        Capsule()
                            .foregroundColor(Color.theme.defaultColor)
                    )
                    .buttonStyle(.plain)

                    Spacer()
                    
                    Button(intent: ChangeContactIntent(index: (entry.currentContactIndex + 1) % entry.contactToDisplay.count)) {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.theme.offWhite)
                    }
                    .frame(width: geo.size.width / 2 - 4, height: 30)
                    .background(
                        Capsule()
                            .foregroundColor(Color.theme.defaultColor)
                    )
                    .buttonStyle(.plain)

                }
            }
            .widgetURL(URL(string: "myapp://contactdetails?name=\(entry.contactToDisplay[entry.currentContactIndex].name)")!)
        }
    }
    
    @ViewBuilder
    private var contactImageView: some View {
        switch entry.contactToDisplay[entry.currentContactIndex].imageName {
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
                    Text(entry.contactToDisplay[entry.currentContactIndex].name.initials)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                )
        }
    }
}

#Preview(as: .systemSmall) {
    WBApp_Widget()
} timeline: {
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0, configuration: .smiley)
}

