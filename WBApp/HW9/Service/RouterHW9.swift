//
//  RouterHW9.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

enum RouteHW9: Hashable {
    case walkthrought
    case verification
    case pinEntering
}

final class RouterHW9: ObservableObject {
    @Published var homeScreen: RouteHW9 = .walkthrought
    @Published var path = NavigationPath()
    
    func push(_ page: RouteHW9) {
        path.append(page)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goToFirst() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func getPage(_ page: RouteHW9) -> some View {
        switch page {
        case .walkthrought:
            WalkthroughView()
                .navigationBarBackButtonHidden()
        case .verification:
            VerificationScreen()
                .navigationBarBackButtonHidden()
        case .pinEntering:
            PinEnteringScreen()
                .navigationBarBackButtonHidden()
        }
    }
}
