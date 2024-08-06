//
//  WalkthroughView.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

struct WalkthroughView: View {
    @EnvironmentObject var router: RouterHW9
    @State private var isUserAgreementPresented: Bool = false
    @State private var isVerificationPresented: Bool = false
    @State private var containerSize: CGSize = .zero
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
                .frame(height: containerSize.adaptiveVerticalPadding(50))
            
            illustrationView
                .padding(.bottom, containerSize.adaptiveVerticalPadding(45))
            
            headlineText
            
            Spacer()
            
            userAgreementButton
                .padding(.bottom, containerSize.adaptiveVerticalPadding(18))
            
            startChatButton
                .padding(.horizontal, containerSize.adaptiveVerticalPadding(24))
                .padding(.bottom, containerSize.adaptiveVerticalPadding(20))
        }
        .background(Color.theme.white)
        .containerSizeGetter($containerSize)
    }
}

extension WalkthroughView {
    private var illustrationView: some View {
        Image(UI.Images.illustration)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 262)
    }
    
    private var headlineText: some View {
        Text(UI.Strings.walkthrought_text)
            .headlineTextStyle()
            .frame(width: 279)
    }
    
    private var userAgreementButton: some View {
        Button(action: { self.isUserAgreementPresented.toggle() }) {
            Text(UI.Strings.userAgreement)
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
                .frame(height: 24)
        }
        .buttonStyle(.plain)
    }
    
    private var startChatButton: some View {
        Button(action: { router.push(.verification) }) {
            Text(UI.Strings.startChating)
                .primaryButtonTextStyle()
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

#Preview {
    WalkthroughView()
}
