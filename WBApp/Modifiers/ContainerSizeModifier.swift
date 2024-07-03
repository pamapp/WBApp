//
//  ContainerSizeModifier.swift
//  WBApp
//
//  Created by Alina Potapova on 03.07.2024.
//

import SwiftUI

struct ContainerSizeModifier: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                backgroundView
            )
    }

    @ViewBuilder
    private var backgroundView: some View {
        if #available(iOS 17.0, *) {
            Color.clear
                .containerRelativeFrame([.vertical, .horizontal]) { length, axes in
                    DispatchQueue.main.async {
                        if axes == .vertical{
                            size.height = length
                        } else {
                            size.width = length
                        }
                    }
                    return 0
                }
        } else {
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        if size == .zero {
                            size = geo.size
                        }
                    }
            }
        }
    }
}
