//
//  OTPEnteringScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

struct OTPEnteringScreen: View {
    @EnvironmentObject var router: RouterHW9
    @ObservedObject private var pinTimer = OTPTimer()

    @State private var containerSize: CGSize = .zero
    @State private var isKeyboardActive: Bool = false
    @State private var showWarningText: Bool = false
    @State private var warningText: String = ""
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                leadingIcon: UI.Icons.back,
                leadingAction: { router.goBack() }
            )
            .padding(.bottom, containerSize ~ 79)
            
            headerTextSection
                .padding(.bottom, containerSize ~ 49)
                .transition(.fadeAndMove(edge: .top))
            
            pinField
                .padding(.bottom, containerSize ~ 20)

            if showWarningText {
                Text(warningText)
                    .metaTextStyle(color: Color.theme.danger)
            }
            
            Spacer()
            
            requestCodeText
                .padding(.bottom, containerSize ~ (isKeyboardActive ? 20 : 60))
                .padding(.horizontal, 24)
        }
        .containerSizeGetter($containerSize)
        .background(
            Color.theme.white
                .ignoresSafeArea(.all)
        )
        .onAppear {
            pinTimer.start(with: router.otpManager.remainingTime(forPhoneNumber: router.phoneNumber) ?? 0)
        }
    }
    
    private func verifyPin(pin: String, completion: (Bool) -> Void) {
        let isValid = router.otpManager.validateOTP(pin, forPhoneNumber: router.phoneNumber)
        
        if isValid {
            completion(true)
        } else {
            showWarningText = pin.count == 4
            warningText = pinTimer.remainingTime > 0 ? UI.Strings.incorrectCode : UI.Strings.codeExpired
            
            completion(false)
        }
    }
}

extension OTPEnteringScreen {
    private var headlineText: some View {
        Text(UI.Strings.enterCode)
            .headlineTextStyle()
    }

    private var infoText: some View {
        Text(UI.Strings.sendingCodeInfo + "\n" + router.phoneNumber)
            .infoTextStyle()
            .frame(width: 253)
    }
    
    private var headerTextSection: some View {
        VStack(spacing: containerSize ~ 10) {
            headlineText
            infoText
        }
    }
    
    private var pinField: some View {
        OTPFieldView(incorrectPin: $showWarningText,
                     isKeyboardActive: $isKeyboardActive,
                     size: containerSize,
                     handler: verifyPin)
    }
    
    private var requestCodeAgainButton: some View {
        Button(action: {
            switch pinTimer.remainingTime {
            case 0...:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            default:
                _ = router.otpManager.generateOTP(forPhoneNumber: router.phoneNumber)
                pinTimer.start(with: router.otpManager.remainingTime(forPhoneNumber: router.phoneNumber) ?? 0)
            }
        }) {
            Text(UI.Strings.requestCodeAgain)
                .font(.subheading2())
                .foregroundColor(Color.theme.defaultColor)
        }
    }
    
    private var validTimer: some View {
        Text("\(UI.Strings.requestCodeAgain) через: \(pinTimer.formattedTime)")
            .metaTextStyle(color: Color.theme.disabled)
    }

    private var requestCodeText: some View {
        Group {
            switch pinTimer.remainingTime {
            case 0...:
                validTimer
            default:
                requestCodeAgainButton
            }
        }
    }
}

#Preview {
    OTPEnteringScreen()
}

