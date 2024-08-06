//
//  PinEnteringScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

struct PinEnteringScreen: View {
    @EnvironmentObject var router: RouterHW9

    var body: some View {
        VStack {
            CustomNavigationBar(
                leadingIcon: UI.Icons.back,
                leadingAction: { router.goBack() }
            )
            
            Spacer()
            
            ProgressView()
            
            Spacer()
        }
    }
}

#Preview {
    PinEnteringScreen()
}
