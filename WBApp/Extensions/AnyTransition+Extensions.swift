//
//  AnyTransition+Extensions.swift
//  WBApp
//
//  Created by Alina Potapova on 08.07.2024.
//

import SwiftUI

extension AnyTransition {
    static func fadeAndMove(edge: Edge) -> AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: edge))
    }
}
