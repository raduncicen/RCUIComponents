//
//  RCText.swift
//  RCTextField
//
//  Created by Radun Çiçen on 25.09.2025.
//

import SwiftUI

public struct RCText: View {

    public let text: String?
    public let attributedString: AttributedString?
    public let textColor: Color
    public let textAlignment: TextAlignment
    public let font: Font
    public let isFullWidth: Bool

    public init(
        text: String,
        textColor: Color,
        textAlignment: TextAlignment = .leading,
        font: Font,
        isFullWidth: Bool = false
    ) {
        self.text = text
        self.attributedString = nil
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.isFullWidth = isFullWidth
    }

    public init(
        attributedString: AttributedString,
        textColor: Color,
        textAlignment: TextAlignment = .leading,
        font: Font,
        isFullWidth: Bool = false
    ) {
        self.text = nil
        self.attributedString = attributedString
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.isFullWidth = isFullWidth
    }

    public var body: some View {
        textView
            .foregroundStyle(textColor)
            .font(font)
            .frame(maxWidth: isFullWidth ? .infinity : nil, alignment: alignment)
            .multilineTextAlignment(textAlignment)
    }

    @ViewBuilder private var textView: some View {
        if let attributedString {
            Text(attributedString)
        } else {
            Text(text ?? .empty)
        }
    }

    private var alignment: Alignment {
        switch textAlignment {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .center:
            return .center
        }
    }
}


// MARK: - SAMPLE USAGE

#Preview {
    RCText(
        text: "Hello World!",
        textColor: .black,
        textAlignment: .leading,
        font: .body
    )

    RCText(
        attributedString: AttributedString(makeStyledSentence()) ,
        textColor: .red,
        textAlignment: .leading,
        font: .system(size: 30, weight: .bold)
    )
}

private func makeStyledSentence() -> NSAttributedString {
    let result = NSMutableAttributedString()

    let intro = NSAttributedString(
        string: "Today is ",
        attributes: [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.darkGray
        ]
    )
    result.append(intro)

    let highlight = NSAttributedString(
        string: "sunny",
        attributes: [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.systemOrange
        ]
    )
    result.append(highlight)

    let outro = NSAttributedString(
        string: " with a light breeze.",
        attributes: [
            .font: UIFont.italicSystemFont(ofSize: 18),
            .foregroundColor: UIColor.systemTeal,
            .kern: 1.2 // add a little spacing for flair
        ]
    )
    result.append(outro)

    let noAttributePart = NSAttributedString(string: "This part has no attributes")
    result.append(noAttributePart)

    return result
}
