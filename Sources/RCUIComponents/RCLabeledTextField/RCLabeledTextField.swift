import SwiftUI
import UIKit

public struct RCLabeledTextField<LeadingAccessory: View, TrailingAccessory: View>: View {
    @ObservedObject private var state: RCLabeledTextFieldState
    private let placeholder: String
    private let theme: RCTextFieldDesignTheme
    private let contentPadding: EdgeInsets
    private let keyboardType: UIKeyboardType
    private let submitLabel: SubmitLabel
    private let textContentType: UITextContentType?
    private let autocapitalization: TextInputAutocapitalization
    private let disableAutocorrection: Bool?
    private let onSubmit: (() -> Void)?
    private let onFocusChanged: ((Bool) -> Void)?
    private let leadingAccessory: () -> LeadingAccessory?
    private let trailingAccessory: () -> TrailingAccessory?

    @FocusState private var isFocused: Bool

    public init(
        state: RCLabeledTextFieldState,
        placeholder: String,
        theme: RCTextFieldDesignTheme = .default,
        contentPadding: EdgeInsets = EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16),
        keyboardType: UIKeyboardType = .default,
        submitLabel: SubmitLabel = .done,
        textContentType: UITextContentType? = nil,
        autocapitalization: TextInputAutocapitalization = .sentences,
        disableAutocorrection: Bool? = nil,
        onSubmit: (() -> Void)? = nil,
        onFocusChanged: ((Bool) -> Void)? = nil,
        @ViewBuilder leadingAccessory: @escaping () -> LeadingAccessory? = { nil },
        @ViewBuilder trailingAccessory: @escaping () -> TrailingAccessory? = { nil }
    ) {
        self._state = ObservedObject(initialValue: state)
        self.placeholder = placeholder
        self.theme = theme
        self.contentPadding = contentPadding
        self.keyboardType = keyboardType
        self.submitLabel = submitLabel
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.disableAutocorrection = disableAutocorrection
        self.onSubmit = onSubmit
        self.onFocusChanged = onFocusChanged
        self.leadingAccessory = leadingAccessory
        self.trailingAccessory = trailingAccessory
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            labelView(style: currentStyle)
            inputContainer(style: currentStyle)
            helperView(style: currentStyle)
        }
        .animation(.easeInOut(duration: 0.2), value: state.status)
        .animation(.easeInOut(duration: 0.2), value: state.text)
    }

    private var currentStyle: RCTextFieldDesignTheme.StatusStyle {
        switch state.status {
        case .disabled:
            return theme.disabled
        case .error:
            return theme.error
        case .validated:
            return theme.validated
        case .normal:
            return state.text.isEmpty ? theme.normal : theme.filled
        }
    }

    @ViewBuilder
    private func labelView(style: RCTextFieldDesignTheme.StatusStyle) -> some View {
        Text(state.label)
            .font(theme.labelTheme.font)
            .foregroundColor(style.labelColor)
    }

    @ViewBuilder
    private func inputContainer(style: RCTextFieldDesignTheme.StatusStyle) -> some View {
        HStack(spacing: 8) {
            if let leading = leadingAccessory() {
                leading
            }

            inputField
                .foregroundColor(theme.textFieldTheme.textColor)
                .font(theme.textFieldTheme.font)
                .disabled(state.isDisabled)
                .accessibilityLabel(state.label)

            if let accessoryIcon = style.accessoryIcon {
                accessoryIcon
                    .foregroundColor(style.labelColor)
            }

            if let trailing = trailingAccessory() {
                trailing
            }
        }
        .padding(contentPadding)
        .background(
            RoundedRectangle(cornerRadius: style.container.cornerRadius)
                .fill(style.container.backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: style.container.cornerRadius)
                .stroke(style.container.borderColor, lineWidth: style.container.borderWidth)
        )
        .disabled(state.isDisabled)
    }

    private var inputField: some View {
        Group {
            if state.isSecure {
                SecureField(
                    "",
                    text: $state.text,
                    prompt: Text(placeholder).foregroundColor(theme.textFieldTheme.placeholderColor)
                )
                .focused($isFocused)
            } else {
                TextField(
                    "",
                    text: $state.text,
                    prompt: Text(placeholder).foregroundColor(theme.textFieldTheme.placeholderColor)
                )
                .focused($isFocused)
            }
        }
        .keyboardType(keyboardType)
        .submitLabel(submitLabel)
        .textInputAutocapitalization(autocapitalization)
        .textContentType(textContentType)
        .disableAutocorrection(disableAutocorrection)
        .onSubmit {
            onSubmit?()
        }
        .onChange(of: isFocused) { newValue in
            onFocusChanged?(newValue)
        }
    }

    @ViewBuilder
    private func helperView(style: RCTextFieldDesignTheme.StatusStyle) -> some View {
        switch state.reservesErrorSpace {
        case true:
            Text(state.errorMessage ?? " ")
                .font(theme.helperTheme.font)
                .foregroundColor(style.helperTextColor)
                .opacity(state.errorMessage == nil ? 0 : 1)
        case false:
            if let error = state.errorMessage {
                Text(error)
                    .font(theme.helperTheme.font)
                    .foregroundColor(style.helperTextColor)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}
