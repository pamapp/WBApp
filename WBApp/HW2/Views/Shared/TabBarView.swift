//
//  TabBarView.swift
//  WBApp
//
//  Created by Alina Potapova on 09.06.2024.
//

import SwiftUI

struct TabItem<Content: View> {
    let title: String
    let imageName: String
    let view: Content
    let route: AppRoute
}

struct TabBarView<Content: View>: View {
    @EnvironmentObject var router: Router
    @State private var circlePosition: CGFloat = 0

    private let tabs: [TabItem<Content>]
    private let tabCount: Int
    private let tabWidth: CGFloat
    
    init(tabs: [TabItem<Content>]) {
        self.tabs = tabs
        self.tabCount = tabs.count
        self.tabWidth = UIScreen.main.bounds.width / CGFloat(tabCount)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $router.selectedRoute) {
                ForEach(tabs, id: \.route) { tab in
                    tab.view
                        .tag(tab.route)
                }
            }
            .onChange(of: router.selectedRoute) { _ in
                if let index = tabs.firstIndex(where: { $0.route == router.baseRoute }) {
                    withAnimation(.smooth(duration: 0.15)) {
                        circlePosition = tabWidth * CGFloat(index)
                    }
                }
            }
            .overlay(
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.route) { tab in
                        tabBarButton(name: tab.imageName, title: tab.title, route: tab.route, tabWidth: tabWidth)
                    }
                }
                .overlay(
                    Circle()
                        .fill(Color.theme.active)
                        .frame(width: 5, height: 5, alignment: .bottom)
                        .position(x: circlePosition + tabWidth / 2, y: 46)
                )
                .frame(height: 70)
                .background(Color.theme.white)
                .padding(.bottom, 15),
                alignment: .bottom
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .tabBarShadow()
    }
}

extension TabBarView {
    private func tabBarButton(name: String, title: String, route: AppRoute, tabWidth: CGFloat) -> some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0.05)) {
                router.navigate(to: route)
            }
        }) {
            switch (router.baseRoute == route) {
            case true:
                Text(title)
                    .font(.bodyText1())
                    .foregroundColor(Color.theme.active)
                    .transition(.scale)
            case false:
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(Color.theme.active)
                    .transition(.scale)
            }
        }
        .buttonStyle(.plain)
        .frame(width: tabWidth, height: 44)
        .padding(.vertical, 6)
    }
}
