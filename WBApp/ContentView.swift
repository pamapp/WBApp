//
//  ContentView.swift
//  WBApp
//
//  Created by Alina Potapova on 04.06.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()

    var body: some View {
        //        WalkthroughView()
        
        TabBarView(tabs: [
            TabItem(title: "Контакты", imageName: "group", view: AnyView(ContactsScreen()), route: .contacts),
            TabItem(title: "Чаты", imageName: "message_circle", view: AnyView(Text("Chats")), route: .chat),
            TabItem(title: "Ещё", imageName: "more_horizontal", view: AnyView(Text("Settings")), route: .settings)
        ])
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}


