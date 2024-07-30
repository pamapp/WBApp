//
//  ContentView.swift
//  WBApp
//
//  Created by Alina Potapova on 04.06.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()
    @StateObject private var routerHW9 = RouterHW9()

    var body: some View {
//        NavigationStack(path: $routerHW9.path) {
//            routerHW9.getPage(.walkthrought)
//                .navigationDestination(for: RouteHW9.self) { page in
//                    routerHW9.getPage(page)
//                }
//        }
//        .environmentObject(routerHW9)
        
        TabBarView(tabs: [
            TabItem(title: "Контакты", imageName: "group", view: AnyView(ContactsScreen()), route: .contacts),
            TabItem(title: "Чаты", imageName: "message_circle", view: AnyView(Text("Chats")), route: .chat),
            TabItem(title: "Ещё", imageName: "more_horizontal", view: AnyView(Text("Settings")), route: .settings)
        ])
        .environmentObject(router)
        .onAppear {
            setupNotifications()
        }
        .onOpenURL { url in
            handleDeepLink(url: url)
        }
    }
}

extension ContentView {
    private func setupNotifications() {
        NotificationCenter.default.addObserver(forName: .openChats, object: nil, queue: .main) { _ in
            router.navigate(to: .chat)
        }
    }
    
    private func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }

        switch components.host {
        case "contactdetails":
            if let name = components.queryItems?.first(where: { $0.name == "initials" })?.value,
               let creationDate = components.queryItems?.first(where: { $0.name == "creationDate" })?.value {
                if let contact = SharedData.shared.contacts.first(where: { $0.name.initials == name && $0.creationDate == creationDate }) {
                        router.navigate(to: .contactDetail, contact: contact)
                }
            }
        default:
            break
        }
    }
}

#Preview {
    ContentView()
}


