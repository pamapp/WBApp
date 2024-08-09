//
//  PersonalChatView.swift
//  WBApp
//
//  Created by Alina Potapova on 05.08.2024.
//

import SwiftUI
import UISystem
import ExyteChat

struct PersonalChatView: View {
    @FocusState private var isInputFocused: Bool
    @StateObject private var vm: ChatVM

    init(vm: ChatVM = ChatVM()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack {
            NavigationBarView(
                title: "Анастасия И.",
                leadingIcon: UI.Icons.back,
                trailingIcon: UI.Icons.search,
                additionalTrailingIcon: UI.Icons.lines,
                leadingAction: { isInputFocused = false},
                trailingAction: {},
                additionalTrailingAction: {}
            )

            ChatView(messages: vm.messages, chatType: .conversation) { draft in
                if !draft.text.isEmpty || !draft.medias.isEmpty || draft.recording != nil {
                    Task {
                        await vm.send(draft: draft)
                    }
                }
            } messageBuilder: { message, positionInGroup, positionInCommentsGroup, showContextMenuClosure, messageActionClosure, showAttachmentClosure in
                ChatMessageView(message: message, positionInUserGroup: positionInGroup)
                    .onTapGesture {
                        isInputFocused = false
                    }
            } inputViewBuilder: { textBinding, attachments, inputViewState, inputViewStyle, inputViewActionClosure, dissmissKeyboardClosure in
                CustomInputView(text: textBinding,
                                attachments: attachments,
                                inputViewStyle: inputViewStyle,
                                inputViewState: inputViewState,
                                inputViewActionClosure: inputViewActionClosure
                )
                .focused($isInputFocused)
            } messageMenuAction: { (action: DefaultMessageMenuAction, defaultActionClosure, message) in
                switch action {
                case .reply:
                    defaultActionClosure(message, .reply)
                    isInputFocused = true
                case .edit:
                    ()
                }
            }
            .headerBuilder({ date in
                chatHeaderView(with: date)
            })
            .chatTheme(colors: ChatTheme.Colors(
                mainBackground: Color.theme.offWhite
            ))
        }
        .background(Color.theme.white)
    }
}

extension PersonalChatView {
    @ViewBuilder
    private func chatHeaderView(with date: Date) -> some View {
        HStack(spacing: 16) {
            VStack { Divider() }
            
            Text(date.dateToString("E, d MMM"))
                .metaTextStyle(color: Color.theme.disabled)
            
            VStack { Divider() }
        }
        .frame(height: 20)
        .padding(.horizontal, 16)
    }
}


#Preview {
    PersonalChatView()
}
