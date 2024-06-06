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
            VStack(alignment: .center) {
                Spacer()
                
                VStack(spacing: adaptivePadding(45, geometry: geometry)) {
                    illustrationImage
                    
                    headlineText
                        .padding(.horizontal, 48)
                }

                Spacer()
                Spacer()
                
                VStack(spacing: adaptivePadding(18, geometry: geometry)) {
                    userAgreementButton

                    startChatButton
                        .padding(.horizontal, adaptivePadding(24, geometry: geometry))
                        .padding(.bottom, adaptivePadding(20, geometry: geometry))
                        .sheet(isPresented: $isStartSheetPresented) {
                            Button(action: { self.isStartSheetPresented.toggle() }) {
                                Text("Dismiss")
                                    .font(.bodyText1())
                                    .foregroundColor(Color.theme.active)
                            }
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private var illustrationImage: some View {
        Image("Illustration")
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
    
    private func adaptivePadding(_ basePadding: CGFloat, geometry: GeometryProxy) -> CGFloat {
        let isLandscape = geometry.size.width > geometry.size.height
        return isLandscape ? basePadding * (geometry.size.height / 812) : basePadding
    }
}

#Preview {
    ContentView_Body()
}


//Drafts: instead sheet

//.fullScreenCover(isPresented: $isStartSheetPresented, content: {
//    Button(action: { self.isStartSheetPresented.toggle() }) {
//        Text("Dismiss")
//            .font(.bodyText1())
//            .foregroundColor(Color.theme.active)
//    }
//})
