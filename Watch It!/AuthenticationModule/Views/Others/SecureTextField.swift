//
//  File.swift
//  
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI

struct SecureTextField: View {
    @FocusState var isFocused
    @State var lastFocus = false
    @State var isSecure = true
    @Binding var text: String
    var placeholder: String
    init(_ placeholder: String, text: Binding<String>) {
        self._text = text
        self.placeholder = placeholder
    }
    var body: some View {
        HStack {
            field
                .roundedFont()
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.5), value: isSecure)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isFocused = lastFocus
                    }
                }
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.fill": "eye.slash.fill")
                    .roundedFont(.callout, weight: .medium)
            }
        }.onChange(of: isFocused) { newValue in
            lastFocus = newValue
        }
    }
    @ViewBuilder var field: some View {
        if isSecure {
            SecureField(placeholder, text: $text)
                .focused($isFocused)
        }else {
            TextField(placeholder, text: $text)
                .focused($isFocused)
        }
    }
}
