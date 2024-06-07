//
//  ContentView_Body.swift
//  WBApp
//
//  Created by Alina Potapova on 06.06.2024.
//

import SwiftUI

struct ContentView_Body: View {
    @State private var isUserAgreementPresented: Bool = false
    @State private var isStartSheetPresented: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(height: geometry.safeAreaInsets.top + adaptivePadding(45, geometry: geometry))

                illustrationImage
                    .frame(minWidth: 262)
                    .frame(width: geometry.size.width - 112)
                    .padding(.bottom, adaptivePadding(45, geometry: geometry))
                
                headlineText
                    .padding(.horizontal, adaptivePadding(48, geometry: geometry))
                
                Spacer()
                
                userAgreementButton
                    .padding(.bottom, adaptivePadding(18, geometry: geometry))
                
                startChatButton
                    .padding(.horizontal, adaptivePadding(24, geometry: geometry))
                    .padding(.bottom, adaptivePadding(20, geometry: geometry))
                    .sheet(isPresented: $isStartSheetPresented) {
                        dismissButton
                    }
            }
            .background(Color.theme.backgroundColor)
        }
    }
    
    private func adaptivePadding(_ value: CGFloat, geometry: GeometryProxy) -> CGFloat {
        return value * geometry.size.height / 812 // 812 - высота экрана в макете
    }
}

extension ContentView_Body {
    private var illustrationImage: some View {
        Image("Illustration")
            .resizable()
            .scaledToFit()
    }
    
    private var headlineText: some View {
        Text("Общайтесь с друзьями и близкими легко")
            .frame(width: 279)
            .font(.headline2())
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .foregroundColor(Color.theme.active)
    }
    
    private var userAgreementButton: some View {
        Button(action: { self.isUserAgreementPresented.toggle() }) {
            Text("Пользовательское соглашение")
                .font(.bodyText1())
                .foregroundColor(Color.theme.active)
        }
        .frame(height: 24)
        .buttonStyle(.plain)
    }
    
    private var startChatButton: some View {
        Button(action: { self.isStartSheetPresented.toggle() }) {
            Text("Начать общаться")
                .font(.subheadline2())
                .foregroundColor(Color.theme.offWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
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
    ContentView_Body()
}
