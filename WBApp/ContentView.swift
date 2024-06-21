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
            TabItem(title: "Контакты", imageName: "group", view: AnyView(ContactsView()), route: .contacts),
            TabItem(title: "Чаты", imageName: "message_circle", view: AnyView(Text("Chats")), route: .chat),
            TabItem(title: "Ещё", imageName: "more_horizontal", view: AnyView(Text("Settings")), route: .settings)
        ])
        .environmentObject(router)
        .onAppear {
            setupNotifications()
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(forName: .openChats, object: nil, queue: .main) { _ in
            router.navigate(to: .chat)
        }
    }
}

#Preview {
    ContentView()
}


