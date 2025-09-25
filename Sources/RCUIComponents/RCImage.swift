//
//  RCImage.swift
//  RCTextField
//
//  Created by Radun Çiçen on 25.09.2025.
//

import SwiftUI

public struct RCImage: View {
    let uiImage: UIImage?
    let image: Image?
    let imageName: String?
    let renderingMode: Image.TemplateRenderingMode?
    let color: Color?
    let contentMode: ContentMode?
    let isResizable: Bool

    public init(
        uiImage: UIImage,
        renderingMode: Image.TemplateRenderingMode? = nil,
        color: Color? = nil,
        contentMode: ContentMode? = nil,
        isResizable: Bool = false
    ) {
        self.uiImage = uiImage
        self.image = nil
        self.imageName = nil
        self.renderingMode = renderingMode
        self.color = color
        self.contentMode = contentMode
        self.isResizable = isResizable
    }

    public init(
        image: Image,
        renderingMode: Image.TemplateRenderingMode? = nil,
        color: Color? = nil,
        contentMode: ContentMode? = nil,
        isResizable: Bool = false
    ) {
        self.uiImage = nil
        self.image = image
        self.imageName = nil
        self.renderingMode = renderingMode
        self.color = color
        self.contentMode = contentMode
        self.isResizable = isResizable
    }

    public init(
        named: String,
        renderingMode: Image.TemplateRenderingMode? = nil,
        color: Color? = nil,
        contentMode: ContentMode? = nil,
        isResizable: Bool = false
    ) {
        self.uiImage = nil
        self.image = nil
        self.imageName = named
        self.renderingMode = renderingMode
        self.color = color
        self.contentMode = contentMode
        self.isResizable = isResizable
    }

    public var body: some View {
        if let color {
            imageView
                .isResizable(isResizable)
                .renderingMode(renderingMode)
                .applyAspectRatio(contentMode: contentMode)
                .foregroundStyle(color)
        } else {
            imageView
                .isResizable(isResizable)
                .renderingMode(renderingMode)
                .applyAspectRatio(contentMode: contentMode)
        }
    }

    private var imageView: Image {
        if let uiImage {
            Image(uiImage: uiImage)
        } else if let imageName {
            Image(imageName)
        } else if let image {
            image
        } else {
            Image(systemName: "questionmark.circle.dashed")
        }
    }
}

