import SwiftUI

public struct RCTextFieldDesignTheme {
    public struct LabelTheme {
        public let textColor: Color
        public let font: Font

        public init(textColor: Color, font: Font) {
            self.textColor = textColor
            self.font = font
        }
    }

    public struct TextFieldTheme {
        public let font: Font
        public let textColor: Color
        public let placeholderColor: Color

        public init(font: Font, textColor: Color, placeholderColor: Color) {
            self.font = font
            self.textColor = textColor
            self.placeholderColor = placeholderColor
        }
    }

    public struct HelperTextTheme {
        public let font: Font
        public let defaultColor: Color

        public init(font: Font, defaultColor: Color) {
            self.font = font
            self.defaultColor = defaultColor
        }
    }

    public struct ContainerTheme {
        public let backgroundColor: Color
        public let borderColor: Color
        public let borderWidth: CGFloat
        public let cornerRadius: CGFloat

        public init(
            backgroundColor: Color,
            borderColor: Color,
            borderWidth: CGFloat,
            cornerRadius: CGFloat
        ) {
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
        }
    }

    public struct StatusStyle {
        public let container: ContainerTheme
        public let labelColor: Color
        public let helperTextColor: Color
        public let accessoryIcon: Image?

        public init(
            container: ContainerTheme,
            labelColor: Color,
            helperTextColor: Color,
            accessoryIcon: Image? = nil
        ) {
            self.container = container
            self.labelColor = labelColor
            self.helperTextColor = helperTextColor
            self.accessoryIcon = accessoryIcon
        }
    }

    public let labelTheme: LabelTheme
    public let textFieldTheme: TextFieldTheme
    public let helperTheme: HelperTextTheme
    public let normal: StatusStyle
    public let filled: StatusStyle
    public let validated: StatusStyle
    public let error: StatusStyle
    public let disabled: StatusStyle

    public init(
        labelTheme: LabelTheme,
        textFieldTheme: TextFieldTheme,
        helperTheme: HelperTextTheme,
        normal: StatusStyle,
        filled: StatusStyle,
        validated: StatusStyle,
        error: StatusStyle,
        disabled: StatusStyle
    ) {
        self.labelTheme = labelTheme
        self.textFieldTheme = textFieldTheme
        self.helperTheme = helperTheme
        self.normal = normal
        self.filled = filled
        self.validated = validated
        self.error = error
        self.disabled = disabled
    }
}

public extension RCTextFieldDesignTheme {
    static var `default`: RCTextFieldDesignTheme {
        let labelFont = Font.system(size: 14, weight: .medium)
        let textFont = Font.system(size: 16)
        let helperFont = Font.system(size: 12)

        let normalContainer = ContainerTheme(
            backgroundColor: Color(white: 0.97),
            borderColor: Color(white: 0.9),
            borderWidth: 1,
            cornerRadius: 12
        )

        let filledContainer = ContainerTheme(
            backgroundColor: Color(white: 0.97),
            borderColor: Color(white: 0.7),
            borderWidth: 1,
            cornerRadius: 12
        )

        let validatedContainer = ContainerTheme(
            backgroundColor: Color(white: 0.97),
            borderColor: Color.green,
            borderWidth: 1.5,
            cornerRadius: 12
        )

        let errorContainer = ContainerTheme(
            backgroundColor: Color(white: 0.97),
            borderColor: Color.red,
            borderWidth: 1.5,
            cornerRadius: 12
        )

        let disabledContainer = ContainerTheme(
            backgroundColor: Color(white: 0.92),
            borderColor: Color(white: 0.85),
            borderWidth: 1,
            cornerRadius: 12
        )

        return RCTextFieldDesignTheme(
            labelTheme: .init(textColor: Color.secondary, font: labelFont),
            textFieldTheme: .init(
                font: textFont,
                textColor: Color.primary,
                placeholderColor: Color.secondary.opacity(0.7)
            ),
            helperTheme: .init(font: helperFont, defaultColor: Color.secondary.opacity(0.8)),
            normal: .init(
                container: normalContainer,
                labelColor: Color.secondary,
                helperTextColor: Color.secondary.opacity(0.8)
            ),
            filled: .init(
                container: filledContainer,
                labelColor: Color.primary,
                helperTextColor: Color.secondary.opacity(0.8)
            ),
            validated: .init(
                container: validatedContainer,
                labelColor: Color.green,
                helperTextColor: Color.green
            ),
            error: .init(
                container: errorContainer,
                labelColor: Color.red,
                helperTextColor: Color.red
            ),
            disabled: .init(
                container: disabledContainer,
                labelColor: Color.secondary,
                helperTextColor: Color.secondary.opacity(0.6)
            )
        )
    }
}
