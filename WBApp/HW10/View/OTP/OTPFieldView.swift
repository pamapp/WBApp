//
//  OTPFieldView.swift
//  WBApp
//
//  Created by Alina Potapova on 10.07.2024.
//

import SwiftUI

extension OTPFieldView {
    private enum Constants {
        static let maxDigits: Int = 4
        static let pinCellWidth: CGFloat = 28
        static let pinCellHeight: CGFloat = 40
        static let pinCellsSpacing: CGFloat = 40
        static let dotSide: CGFloat = 24
    }
}

public struct OTPFieldView: View {
    @State private var isDisabled = false
    @State private var pin: String = ""
    
    @Binding var incorrectPin: Bool
    @Binding var isKeyboardActive: Bool
   
    var size: CGSize
    var handler: (String, (Bool) -> Void) -> Void

    public var body: some View {
        VStack {
            ZStack {
                pinDots
                backgroundField
            }
        }
    }
    
    private func submitPin() {
        guard !pin.isEmpty else { return }
        
        pin = pin.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        pin = String(pin.prefix(Constants.maxDigits))
        
        incorrectPin = false
        
        if pin.count == Constants.maxDigits {
            handler(pin) { isSuccess in
                isDisabled = isSuccess
            }
        }
    }
}

extension OTPFieldView {
    private var pinDots: some View {
        HStack(spacing: size ~ Constants.pinCellsSpacing) {
            ForEach(0..<Constants.maxDigits, id: \.self) { index in
                pinDotView(at: index)
                    .frame(width: size ~ Constants.pinCellWidth, height: size ~ Constants.pinCellHeight)
            }
        }
    }
    
    private func pinDotView(at index: Int) -> some View {
        let isDotVisible = index < pin.count
        
        return Group {
            switch isDotVisible {
            case true:
                Text(pin.digits[index])
                    .font(.heading1())
            default:
                Circle()
                    .frame(width: size ~ Constants.dotSide, height: size ~ Constants.dotSide)
                    .foregroundColor(Color.theme.offWhite)
                    .padding(.horizontal, 5)
            }
        }
    }
    
    private var backgroundField: some View {
        TextField("", text: $pin, onEditingChanged: { edit in isKeyboardActive = edit }, onCommit: submitPin)
            .textFieldStyle(PinFieldStyle())
            .disabled(isDisabled)
            .onChange(of: pin) { _ in
                self.submitPin()
            }
    }
}
