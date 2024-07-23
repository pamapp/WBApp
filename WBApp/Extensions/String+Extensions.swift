//
//  String+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 14.06.2024.
//

import SwiftUI

infix operator == : ComparisonPrecedence

extension String {
    static func == (lhs: String, rhs: (String, OTPManager)) -> Bool {
        var (phoneNumber, otpManager) = rhs
        return otpManager.validateOTP(lhs, forPhoneNumber: phoneNumber)
    }
}

extension String {
    var digits: [String] {
        return self.compactMap { $0.isNumber ? String($0) : "" }
    }
}

extension String {
    var initials: String {
        let components = self.split(separator: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }
        return initials.joined()
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String) -> String {
        let pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var formattedNumber = ""
        var pureIndex = pureNumber.startIndex
        
        for patternCharacter in pattern where pureIndex < pureNumber.endIndex {
            if patternCharacter == "0" {
                formattedNumber.append(pureNumber[pureIndex])
                pureIndex = pureNumber.index(after: pureIndex)
            } else {
                formattedNumber.append(patternCharacter)
            }
        }
        
        return formattedNumber
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
