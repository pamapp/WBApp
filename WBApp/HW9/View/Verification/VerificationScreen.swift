//
//  VerificationScreen.swift
//  WBApp
//
//  Created by Alina Potapova on 04.07.2024.
//

import SwiftUI
import UIKit

struct VerificationScreen: View {
    @EnvironmentObject var router: RouterHW9

    @State private var isKeyboardActive: Bool = false
    @State private var containerSize: CGSize = .zero
    @State private var selectedCountry: String = "RU"
    @State private var phoneNumber = ""

    private var isButtonActive: Bool {
        phoneNumber.filter({ $0.isNumber }).count == CountryCodesProvider.digitsCount(for: selectedCountry)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                leadingIcon: UI.Icons.back,
                leadingAction: {
                    router.goBack()
                }
            )
            .padding(.bottom, containerSize.adaptiveVerticalPadding(79))

            if !isKeyboardActive {
                headerTextSection
                    .padding(.bottom, containerSize.adaptiveVerticalPadding(49))
                    .transition(.fadeAndMove(edge: .top))
            }

            phoneInputSection
                .padding(.bottom, containerSize.adaptiveVerticalPadding(32))
                .padding(.horizontal, 24)

            Spacer()

            continueButton
                .padding(.bottom, containerSize.adaptiveVerticalPadding(isKeyboardActive ? 60 : 20))
                .padding(.horizontal, 24)
        }
        .containerSizeGetter($containerSize)
        .background(
            Color.theme.white
                .ignoresSafeArea(.all)
                .onTapGesture {
                    dismissKeyboard()
                }
        )
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.endEditing()
        withAnimation {
            isKeyboardActive = false
        }
    }
    
    private func formatPhoneNumberIfNeeded() {
        guard !isButtonActive else {
            dismissKeyboard()
            return
        }
        
        let format = CountryCodesProvider.phoneFormat(for: selectedCountry)
        let formatted = phoneNumber.applyPatternOnNumbers(pattern: format)
        if formatted != phoneNumber {
            phoneNumber = formatted
        }
    }
}

extension VerificationScreen {
    private var headlineText: some View {
        Text(UI.Strings.enterPhoneNumber)
            .headlineTextStyle()
    }

    private var infoText: some View {
        Text(UI.Strings.infoText)
            .infoTextStyle()
            .frame(width: 253)
    }
    
    private var headerTextSection: some View {
        VStack(spacing: containerSize.adaptiveVerticalPadding(10)) {
            headlineText
            infoText
        }
    }
    
    private var countryPicker: some View {
        Picker("", selection: $selectedCountry) {
            ForEach(CountryCodesProvider.codes.keys.sorted(), id: \.self) { countryCode in
                HStack {
                    Image(CountryCodesProvider.flag(for: countryCode))
                    Text(CountryCodesProvider.phoneCode(for: countryCode))
                }
                .tag(countryCode)
            }
        }
        .countryPickerStyle(containerSize: containerSize, selectedCountry: selectedCountry)
    }

    private var phoneTextField: some View {
        TextField(CountryCodesProvider.phoneFormat(for: selectedCountry), text: $phoneNumber, onEditingChanged: { (edit) in
            withAnimation {
                isKeyboardActive = edit
            }
        })
        .textFieldStyle(SimpleTextFieldStyle(height: containerSize.adaptiveVerticalPadding(36)))
        .onChange(of: selectedCountry) { _ in
            formatPhoneNumberIfNeeded()
        }
        .onChange(of: phoneNumber) { newValue in
            formatPhoneNumberIfNeeded()
        }
    }
    
    private var phoneInputSection: some View {
        HStack(spacing: containerSize.adaptiveVerticalPadding(10)) {
            countryPicker
            phoneTextField
        }
    }
    
    private var continueButton: some View {
        Button(action: {
            if isButtonActive {
                router.push(.pinEntering)
            } else {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        }) {
            Text(UI.Strings.continueText)
                .primaryButtonTextStyle()
        }
        .buttonStyle(PrimaryButtonStyle())
        .opacity(isButtonActive ? 1 : 0.5)
        .allowsHitTesting(true)
    }
}

#Preview {
    VerificationScreen()
}
