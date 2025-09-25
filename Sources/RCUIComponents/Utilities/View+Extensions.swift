//
//  View+Extensions.swift
//  RCTextField
//
//  Created by Radun Çiçen on 25.09.2025.
//

import SwiftUI

extension View {
    func addBorder(
        lineWidth: CGFloat,
        color: Color,
        cornerRadius: CGFloat,
        inset: CGFloat = 0
    ) -> some View {
        self.overlay(content: {
            RoundedRectangle(cornerRadius: cornerRadius)
                .inset(by: inset)
                .stroke(lineWidth: lineWidth)
                .foregroundStyle(color)
        })
    }
}
