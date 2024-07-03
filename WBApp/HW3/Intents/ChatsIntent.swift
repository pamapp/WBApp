//
//  ChatsIntent.swift
//  WBApp
//
//  Created by Alina Potapova on 21.06.2024.
//

import Foundation
import AppIntents

final class ChatsIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Chats in WBApp"
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        NotificationCenter.default.post(name: .openChats, object: nil)
        return .result()
    }
}

extension Notification.Name {
    static let openChats = Notification.Name("openChats")
}
