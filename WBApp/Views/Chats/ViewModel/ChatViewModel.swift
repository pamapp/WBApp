//
//  ChatViewModel.swift
//  WBApp
//
//  Created by Alina Potapova on 05.08.2024.
//

import SwiftUI
import ExyteChat

final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = TestData.messages
        
    func send(draft: DraftMessage) async {
        let newMessage = await Message.makeMessage(id: UUID().uuidString, user: User(id: "1", name: "Steve", avatarURL: nil, isCurrentUser: true), draft: draft)
        await MainActor.run {
            self.messages.append(newMessage)
        }
    }
}

struct TestData {
    static let messages: [Message] = {
        let message1 = Message(
            id: "454",
            user: User(id: "1", name: "Steve", avatarURL: nil, isCurrentUser: true),
            createdAt: Date().addingTimeInterval(-180000),
            text: "че каво"
        )
        
        let message2 = Message(
            id: "455",
            user: User(id: "345", name: "Dog", avatarURL: nil, isCurrentUser: false),
            createdAt: Date().addingTimeInterval(-179000),
            text: "Привет! Как дела, че каво",
            replyMessage: message1.toReplyMessage()
        )
        
        let message3 = Message(
            id: "456",
            user: User(id: "345", name: "Dog", avatarURL: nil, isCurrentUser: false),
            createdAt: Date().addingTimeInterval(-178000),
            text: "Смотри какая собака у меня!"
        )
        
        let message4 = Message(
            id: "457",
            user: User(id: "345", name: "Dog", avatarURL: nil, isCurrentUser: false),
            createdAt: Date().addingTimeInterval(-177000),
            text: "Зовут Белок",
            attachments: [
                Attachment(
                    id: "23",
                    url: URL(string: "https://cdn2.thedogapi.com/images/Bymjyec4m.jpg")!,
                    type: .image
                )
            ]
        )
        
        let message5 = Message(
            id: "458",
            user: User(id: "1", name: "Steve", avatarURL: nil, isCurrentUser: true),
            text: "Норм че, давай встретимся сегодня",
            replyMessage: message2.toReplyMessage()
        )
        
        let message6 = Message(
            id: "459",
            user: User(id: "1", name: "Steve", avatarURL: nil, isCurrentUser: true),
            text: "Крутой Белок",
            replyMessage: message4.toReplyMessage()
        )
        
        return [message1, message2, message3, message4, message5, message6]
    }()
}
