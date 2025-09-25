import SwiftUI

public enum RCTextFieldStatus: Equatable {
    case normal
    case validated
    case error(message: String?)
    case disabled

    public var errorMessage: String? {
        if case .error(let message) = self { return message }
        return nil
    }

    public var isDisabled: Bool {
        if case .disabled = self { return true }
        return false
    }
}

public final class RCLabeledTextFieldState: ObservableObject, Identifiable {
    public let id = UUID()

    @Published public var label: String
    @Published public var text: String
    @Published public var status: RCTextFieldStatus
    @Published public var isSecure: Bool
    @Published public var reservesErrorSpace: Bool

    public init(
        label: String,
        text: String = "",
        status: RCTextFieldStatus = .normal,
        isSecure: Bool = false,
        reservesErrorSpace: Bool = true
    ) {
        self.label = label
        self.text = text
        self.status = status
        self.isSecure = isSecure
        self.reservesErrorSpace = reservesErrorSpace
    }

    public var isDisabled: Bool {
        status.isDisabled
    }

    public var errorMessage: String? {
        status.errorMessage
    }

    public func setStatus(_ status: RCTextFieldStatus) {
        self.status = status
    }

    public func setError(_ message: String? = nil) {
        status = .error(message: message)
    }

    public func setValidated() {
        status = .validated
    }

    public func reset() {
        status = .normal
    }

    public func setDisabled(_ disabled: Bool) {
        status = disabled ? .disabled : .normal
    }
}
