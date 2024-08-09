//
//  ReplyMessageView.swift
//  WBApp
//
//  Created by Alina Potapova on 09.08.2024.
//

import SwiftUI
import ExyteChat
import UISystem

struct ReplyMessageView: View {
    var reply: ReplyMessage
    var lineLimit: Int
    var isCurrentUser: Bool
    
    private var replyLineColor: Color {
        isCurrentUser ? Color.theme.white : Color.theme.defaultColor
    }
    
    private var replyBackgroundColor: Color {
        isCurrentUser ? Color.theme.darkColor : Color.theme.offWhite
    }
    
    var body: some View {
        HStack(spacing: 0) {
            lineView
            
            VStack(alignment: .leading, spacing: 4) {
                userName
                
                userAttachments
                
                userTextMessage
            }
            .padding(8)
            
            Spacer()
        }
        .background(replyBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension ReplyMessageView {
    private var lineView: some View {
        Rectangle()
            .foregroundColor(replyLineColor)
            .frame(width: 4)
    }
    
    private var userName: some View {
        Text(reply.user.name)
            .foregroundStyle(replyLineColor)
            .font(.metadata3())
    }
    
    @ViewBuilder
    private var userTextMessage: some View {
        if !reply.text.isEmpty {
            Text(reply.text)
                .foregroundColor(isCurrentUser ? Color.white : Color.theme.active)
                .font(.bodyText2(14))
                .lineLimit(lineLimit)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    private var userAttachments: some View {
        if !reply.attachments.isEmpty {
            ForEach(reply.attachments, id: \.id) { at in
                AsyncImage(url: at.thumbnail) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 30, height: 30)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    default:
                        Image(systemName: "cross")
                    }
                }
            }
        }
    }
}
