//
//  OTPEnteringScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI
import UISystem

struct OTPEnteringScreen: View {
    @EnvironmentObject var router: RouterHW9
    @ObservedObject private var otpTimer = OTPTimer()

    @State private var containerSize: CGSize = .zero
    @State private var isKeyboardActive: Bool = false
    @State private var showWarningText: Bool = false
    @State private var warningString: String = ""
    
    var body: some View {
        VStack {
            NavigationBarView(
                leadingIcon: UI.Icons.back,
                leadingAction: { router.goBack() }
            )
            .padding(.bottom, containerSize ~ 79)
            
            headerTextSection
                .padding(.bottom, containerSize ~ 49)
            
            pinField
                .padding(.bottom, containerSize ~ 20)

            if showWarningText {
                warningText
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
            startTimer()
        }
    }
    
    private func startTimer() {
        otpTimer.start(with: router.otpManager.remainingTime(forPhoneNumber: router.phoneNumber) ?? 0)
    }
    
    private func setWarning(for pin: String) {
        showWarningText = pin.count == 4
        warningString = otpTimer.remainingTime > 0 ? UI.Strings.incorrectCode : UI.Strings.codeExpired
    }
    
    private func verifyPin(pin: String, completion: (Bool) -> Void) {        
        if pin == (router.phoneNumber, router.otpManager) {
            completion(true)
            router.push(.registration)
        } else {
            setWarning(for: pin)
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
    
    private var warningText: some View {
        Text(warningString)
            .metaTextStyle(color: Color.theme.danger)
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
            switch otpTimer.remainingTime {
            case 0...:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            default:
                _ = router.otpManager.generateOTP(forPhoneNumber: router.phoneNumber)
                startTimer()
            }
        }) {
            Text(UI.Strings.requestCodeAgain)
                .font(.subheading2())
                .foregroundColor(Color.theme.defaultColor)
        }
    }
    
    private var validTimer: some View {
        Text(UI.Strings.requestCodeAgain + " " + UI.Strings.after + ": " + otpTimer.formattedTime)
            .metaTextStyle(color: Color.theme.disabled)
    }

    private var requestCodeText: some View {
        Group {
            switch otpTimer.remainingTime {
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

