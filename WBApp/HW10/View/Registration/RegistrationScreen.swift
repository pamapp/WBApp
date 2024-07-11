//
//  RegistrationScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 11.07.2024.
//

import SwiftUI


struct RegistrationScreen: View {
    @EnvironmentObject var router: RouterHW9

    var body: some View {
        VStack {
            CustomNavigationBar(
                title: UI.Strings.profile,
                leadingIcon: UI.Icons.back,
                leadingAction: { router.goBack(steps: 2) }
            )
            
            Spacer()
            
            Text("Registration")
            
            Spacer()
        }
        .background(
            Color.theme.white
                .ignoresSafeArea(.all)
        )
    }
}
