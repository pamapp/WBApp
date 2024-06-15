//
//  UIApplication+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 14.06.2024.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func beginEditing() {
        sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}
