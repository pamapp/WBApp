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
