//
//  RCButton.swift
//  RCTextField
//
//  Created by Radun Çiçen on 25.09.2025.
//

public struct RCButtonTheme {
    public let titleColor: Color
    public let disabledTitleColor: Color
    public let backgroundColor: Color
    public let disabledBackgroundColor: Color
    public let height: CGFloat?
    public let cornerRadius: CGFloat?
    public let borderWidth: CGFloat?
    public let borderColor: Color?
    public let font: Font
}

public struct RCButton<LeadingView: View, TrailingView: View>: View {

    @Environment(\.isEnabled) var isEnabled
    public let title: String?
    public let attributedString: String?
    public let action: () -> Void
    public let fullWidth: Bool
    public let theme: RCButtonTheme
    public var leadingView: (() -> LeadingView?)?
    public var trailingView: (() -> TrailingView?)?


    public init(
        action: @escaping () -> Void,
        title: String,
        theme: RCButtonTheme,
        fullWidth: Bool = true,
        @ViewBuilder leadingView: @escaping () -> LeadingView? = { nil },
        @ViewBuilder trailingView: @escaping () -> TrailingView? = { nil }
    ) {
        self.action = action
        self.title = title
        self.attributedString = nil
        self.theme = theme
        self.fullWidth = fullWidth
        self.leadingView = leadingView
        self.trailingView = trailingView
    }

    public init(
        action: @escaping () -> Void,
        attributedString: String,
        theme: RCButtonTheme,
        fullWidth: Bool = true,
    ) {
        self.action = action
        self.title = nil
        self.attributedString = attributedString
        self.theme = theme
        self.fullWidth = fullWidth
    }

    public var body: some View {
        Button(action: action) {
            labelView
                .tint(isEnabled ? theme.titleColor : theme.disabledTitleColor)
                .font(theme.font)
                .frame(maxWidth: fullWidth ? .infinity : nil, minHeight: theme.height, maxHeight: theme.height)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadius ?? 0)
                        .stroke(
                            theme.borderColor ?? .clear,
                            lineWidth: theme.borderWidth ?? 0
                        )
                )
        }
        .background(
            isEnabled
            ? theme.backgroundColor
            : theme.disabledBackgroundColor
        )
        .cornerRadius(theme.cornerRadius ?? 0)
    }

    @ViewBuilder private var labelView: some View {
        HStack(spacing: .zero) {
            leadingView?()
            if let attributedString {
                Text(attributedString)
            } else {
                Text(title ?? .empty)
            }
            trailingView?()
        }
    }
}

// MARK: CONVENIENCE INITs to support generic views.
extension RCButton {
    public init(
        action: @escaping () -> Void,
        title: String,
        theme: RCButtonTheme,
        fullWidth: Bool = true,
        @ViewBuilder trailingView: @escaping () -> TrailingView? = { nil }
    ) where LeadingView == EmptyView {
        self.init(
            action: action,
            title: title,
            theme: theme,
            fullWidth: fullWidth,
            leadingView: { EmptyView() },
            trailingView: trailingView
        )
    }

    public init(
        action: @escaping () -> Void,
        title: String,
        theme: RCButtonTheme,
        fullWidth: Bool = true,
        @ViewBuilder leadingView: @escaping () -> LeadingView? = { nil },
    ) where TrailingView == EmptyView {
        self.init(
            action: action,
            title: title,
            theme: theme,
            fullWidth: fullWidth,
            leadingView: leadingView,
            trailingView: { EmptyView() }
        )
    }

    public init(
        action: @escaping () -> Void,
        title: String,
        theme: RCButtonTheme,
        fullWidth: Bool = true,
    ) where LeadingView == EmptyView, TrailingView == EmptyView {
        self.init(
            action: action,
            title: title,
            theme: theme,
            fullWidth: fullWidth,
            leadingView: { EmptyView() },
            trailingView: { EmptyView() }
        )
    }
}


#Preview {
    RCButton(
        action: { print("Button Tapped" )
        },
        title: "Some Title",
        theme: .sampleButton,
        fullWidth: true,
        trailingView: {
            RCImage(
                uiImage: .init(systemName: "chevron.right")!,
                renderingMode: .template,
                color: .white,
                isResizable: false
            )
            .padding(.leading, 8)
        }
    )
    .padding()
    //  .disabled(true)
}


fileprivate extension RCButtonTheme {
    static let sampleButton: RCButtonTheme = .init(
        titleColor: .white,
        disabledTitleColor: .red,
        backgroundColor: .blue,
        disabledBackgroundColor: .lightGray,
        height: 54,
        cornerRadius: 8,
        borderWidth: 1,
        borderColor: .orange,
        font: .system(size: 18, weight: .semibold)
    )
}
