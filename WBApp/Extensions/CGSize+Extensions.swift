//
//  CGSize+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 03.07.2024.
//

import Foundation

extension CGSize {
    func adaptiveVerticalPadding(_ value: CGFloat, relativeTo referenceHeight: CGFloat = 812) -> CGFloat {
        value * height / referenceHeight
    }
}
