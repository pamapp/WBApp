//
//  String+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 14.06.2024.
//

import SwiftUI

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
