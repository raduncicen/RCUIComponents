import SwiftUI

struct RCLabeledTextFieldExampleView: View {
    @StateObject private var firstNameState = RCLabeledTextFieldState(label: "First Name")
    @StateObject private var lastNameState = RCLabeledTextFieldState(
        label: "Last Name",
        reservesErrorSpace: false
    )

    var body: some View {
        VStack(spacing: 24) {
            RCLabeledTextField<EmptyView, EmptyView>(
                state: firstNameState,
                placeholder: "Enter your first name"
            )

            RCLabeledTextField<EmptyView, EmptyView>(
                state: lastNameState,
                placeholder: "Enter your last name",
                theme: .default
            )

            actions
        }
        .padding()
        .onAppear {
            firstNameState.setValidated()
            lastNameState.setError("Last name cannot be empty")
        }
    }

    private var actions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Simulate state changes")
                .font(.headline)

            HStack {
                Button("Normal") {
                    firstNameState.reset()
                    lastNameState.reset()
                }
                Button("Validated") {
                    firstNameState.setValidated()
                }
                Button("Error") {
                    lastNameState.setError("Please review your last name")
                }
                Button("Hide Error Text") {
                    lastNameState.setError(nil)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    RCLabeledTextFieldExampleView()
}
