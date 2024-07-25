//
//  PatternsApp.swift
//  Patterns
//
//  Created by Alina Potapova on 25.07.2024.
//

import SwiftUI

// MARK: - Dependency Injection pattern -

@main
struct PatternsApp: App {
    @StateObject private var viewModel = BookListViewModel() // Экземпляр, который будет внедрен в зависимости

    var body: some Scene {
        WindowGroup {
            BookListView()
                .environmentObject(viewModel) // Bнедрение зависимости: передача viewModel дочерним представлениям
        }
    }
}
