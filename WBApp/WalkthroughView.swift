//
//  ContentView_Body.swift
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
                    .frame(height: geo.safeAreaInsets.top + geo.adaptivePadding(45))

                illustrationView
                    .padding(.bottom, geo.adaptivePadding(45))
                
                headlineText
                
                Spacer()
                
                userAgreementButton
                    .padding(.bottom, geo.adaptivePadding(18))
                
                startChatButton
                    .padding(.horizontal, geo.adaptivePadding(24))
                    .padding(.bottom, geo.adaptivePadding(20))
                    .sheet(isPresented: $isStartSheetPresented) {
                        dismissButton
                    }
            }
            .background(Color.theme.backgroundColor)
        }
    }
}

extension WalkthroughView {
    private var illustrationView: some View {
        Image("Illustration")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 262)
    }
    
    private var headlineText: some View {
        Text("Общайтесь с друзьями и близкими легко")
            .font(.headline2())
            .foregroundColor(Color.theme.active)
            .multilineTextAlignment(.center)
            .frame(width: 279)
    }
    
    private var userAgreementButton: some View {
        Button(action: { self.isUserAgreementPresented.toggle() }) {
            Text("Пользовательское соглашение")
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
                .frame(height: 24)
        }
        .buttonStyle(.plain)
    }
    
    private var startChatButton: some View {
        Button(action: { self.isStartSheetPresented.toggle() }) {
            Text("Начать общаться")
                .font(.subheadline2())
                .foregroundColor(Color.theme.offWhite)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    private var dismissButton: some View {
        Button(action: { self.isStartSheetPresented.toggle() }) {
            Text("Dismiss")
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
        }
    }
}

#Preview {
    WalkthroughView()
}
