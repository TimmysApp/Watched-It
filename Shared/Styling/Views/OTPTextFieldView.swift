//
//  OTPTextFieldView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/02/2023.
//

import SwiftUI

public struct OTPTextFieldView: UIViewRepresentable {
//MARK: - Properties
    private var placeholder: String
    private var action: (() async -> Void)?
    @Binding private var text: String
}

//MARK: - Initializers
extension OTPTextFieldView {
    public init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    private init(_ placeholder: String, text: Binding<String>, action: (() async -> Void)?) {
        self.placeholder = placeholder
        self._text = text
        self.action = action
    }
}

//MARK: - Functions
extension OTPTextFieldView {
    public func makeUIView(context: Context) -> OTPTextField {
        let textField = OTPTextField()
        textField.placeholder = placeholder
        textField.text = text
        textField.delegate = context.coordinator
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.action = action
        return textField
    }
    public func updateUIView(_ uiView: OTPTextField, context: Context) {
        uiView.text = text
    }
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
}
//MARK: - Modifiers
public extension OTPTextFieldView {
    func onEmptyDelete(_ action: @escaping () async -> Void) -> Self {
        return OTPTextFieldView(placeholder, text: $text, action: action)
    }
}
//MARK: - Others
public extension OTPTextFieldView {
    class OTPTextField: UITextField {
        var action: (() async -> Void)?
        public override func deleteBackward() {
            super.deleteBackward()
            guard text?.isEmpty ?? true else {return}
            Task {
                await action?()
            }
        }
    }
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
            text = newString
            return true
        }
    }
}
