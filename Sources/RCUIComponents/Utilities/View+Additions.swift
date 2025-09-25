//
//  View+Extensions.swift
//  DerayahSmart
//
//  Created by Radun Çiçen on 23.09.2025.
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
    
    @ViewBuilder
    public func applyAspectRatio(contentMode: ContentMode?, aspectRatio: CGFloat? = nil) -> some View {
        if let contentMode = contentMode {
            self.aspectRatio(aspectRatio, contentMode: contentMode)
        } else {
            self
        }
    }
    
}
