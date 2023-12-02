//
//  AuthTextField.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 18/05/1445 AH.
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    @Binding var text: String
    @Binding var isLoading: Bool
    var validator: (() async -> (Bool, String))? = nil
    @State private var isValid: (Bool, String) = (true, "")

    var body: some View {
        VStack(spacing: 0) {
            if text != "" {
                Text(placeholder)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
            }
            HStack {
                // TextField
                if isSecure {
                    SecureField(text: $text) {
                        Text(placeholder)
                    }
                    .keyboardType(keyboardType)
                    .onChange(of: text) {
                        if let validator = validator{
                            Task {
                                isValid = await validator()
                            }
                        }
                    }
                    .tint(Color(.primary))
                    .foregroundStyle(Color(.primary))
                } else {
                    TextField(text: $text) {
                        Text(placeholder)
                    }
                    .keyboardType(keyboardType)
                    .onChange(of: text) {
                        if let validator = validator{
                            Task {
                                isValid = await validator()
                            }
                        }                    }
                    .tint(Color(.primary))
                    .foregroundStyle(Color(.primary))
                }

                // Trailing Icon
                if isLoading {
                    ProgressView()
                } else {
                    if !text.isEmpty && validator != nil {
                        Image(systemName: isValid.0 ? "checkmark" : "exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .fontWeight(.bold)
                            .frame(width: 12, height: 12)
                            .padding(4)
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .fill(isValid.0 ? .green : .red)
                                    .frame(width: 24)
                            )
                    }
                }
            } //: HStack
            .padding(.horizontal, 32)
            .padding(.bottom, 8)

            Divider()
                .padding(.horizontal, 32)

            if !text.isEmpty && !isLoading && !isValid.0 {
                HStack {
                    Text(isValid.1)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 8)
                }
                .background(.red)
                .overlay {
                    let triangleSize = 8
                    Path { path in
                        path.move(to: CGPoint(x: 32 - triangleSize, y: 0))
                        path.addLine(to: CGPoint(x: 32, y: -triangleSize))
                        path.addLine(to: CGPoint(x: 32 + triangleSize, y: 0))
                    }
                    .foregroundColor(.red)
                }
            }
        } //: VStack
    }
}

#Preview {
    AuthTextField(placeholder: "Name", text: .constant(""), isLoading: .constant(true)) 
}
