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
                    changeContactButton(imageName: "chevron.left",
                                        intentIndex: (entry.currentContactIndex - 1 + entry.contactToDisplay.count) % entry.contactToDisplay.count,
                                        geo: geo
                    )
                    
                    Spacer()
                    
                    changeContactButton(imageName: "chevron.right",
                                        intentIndex: (entry.currentContactIndex + 1) % entry.contactToDisplay.count,
                                        geo: geo
                    )
                }
            }
            .widgetURL(URL(string: "myapp://contactdetails?name=\(entry.contactToDisplay[entry.currentContactIndex].name)")!)
        }
    }
}

extension WBApp_WidgetSmallView {
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
    
    private func changeContactButton(imageName: String, intentIndex: Int, geo: GeometryProxy) -> some View {
        Button(intent: ChangeContactIntent(index: (intentIndex))) {
            Image(systemName: imageName)
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

#Preview(as: .systemSmall) {
    WBApp_Widget()
} timeline: {
    WidgetEntry(contactToDisplay: Array(SharedData.shared.contacts), currentContactIndex: 0)
}

