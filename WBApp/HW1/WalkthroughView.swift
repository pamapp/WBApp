//
//  WalkthroughView.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

struct WalkthroughView: View {
    @State private var isUserAgreementPresented: Bool = false
    @State private var isStartSheetPresented: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: geo.safeAreaInsets.top + geo.adaptiveVerticalPadding(45))

                illustrationView
                    .padding(.bottom, geo.adaptiveVerticalPadding(45))
                
                headlineText
                
                Spacer()
                
                userAgreementButton
                    .padding(.bottom, geo.adaptiveVerticalPadding(18))
                
                startChatButton
                    .padding(.horizontal, geo.adaptiveVerticalPadding(24))
                    .padding(.bottom, geo.adaptiveVerticalPadding(20))
                    .sheet(isPresented: $isStartSheetPresented) {
                        dismissButton
                    }
            }
            .background(Color.theme.white)
        }
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
            .font(.heading2())
            .foregroundColor(Color.theme.active)
            .multilineTextAlignment(.center)
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
        Button(action: { self.isStartSheetPresented.toggle() }) {
            Text(UI.Strings.startChating)
                .font(.subheading2())
                .foregroundColor(Color.theme.offWhite)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    private var dismissButton: some View {
        Button(action: { self.isStartSheetPresented.toggle() }) {
            Text(UI.Strings.dismiss)
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
        }
    }
}

#Preview {
    WalkthroughView()
}
