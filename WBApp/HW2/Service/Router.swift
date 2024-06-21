//
//  Router.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import Combine

enum AppRoute: Hashable {
    case contacts
    case contactDetail(_ contact: Contact)
    case addContact
    case chat
    case settings
}

final class Router: ObservableObject {
    @Published var selectedRoute: AppRoute = .contacts

    var baseRoute: AppRoute {
        switch selectedRoute {
        case .contacts, .contactDetail, .addContact:
            return .contacts
        case .chat:
            return .chat
        case .settings:
            return .settings
        }
    }

    func navigate(to route: AppRoute) {
        self.selectedRoute = route
    }
}

