//
//  WBApp_WidgetSmallView.swift
//  WBApp
//
//  Created by Alina Potapova on 17.06.2024.
//

import SwiftUI

struct SmallView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            
            Text(entry.contactToDisplay[entry.currentContactIndex].name)
                .font(.bodyText1())
            
            HStack {
                Button(intent: ChangeContactIntent(index: (entry.currentContactIndex - 1 + entry.contactToDisplay.count) % entry.contactToDisplay.count)) {
                    Text("<")
                        .foregroundStyle(.blue)
                }
                .background(
                    Capsule()
                        .foregroundColor(Color.theme.defaultColor)
                )
                
                Spacer()
                
                Button(intent: ChangeContactIntent(index: (entry.currentContactIndex + 1) % entry.contactToDisplay.count)) {
                    Text(">")
                        .foregroundStyle(.blue)
                }
                .background(
                    Capsule()
                        .foregroundColor(Color.theme.defaultColor)
                )
            }
        }
    }
}
