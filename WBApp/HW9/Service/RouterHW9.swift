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
    case registration
}

final class RouterHW9: ObservableObject {
    @Published var path = NavigationPath()
    @Published var phoneNumber = ""

    var otpManager = OTPManager(otpValidityDuration: 30)

    func push(_ page: RouteHW9) {
        path.append(page)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func goToFirst() {
        path.removeLast(path.count)
    }
    
    func goBack(steps: Int) {
         guard steps > 0, steps <= path.count else { return }
         path.removeLast(steps)
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
            OTPEnteringScreen()
                .navigationBarBackButtonHidden()
        case .registration:
            RegistrationScreen()
                .navigationBarBackButtonHidden()
        }
    }
}
