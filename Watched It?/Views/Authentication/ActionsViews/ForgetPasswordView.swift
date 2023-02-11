//
//  ForgetPasswordView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 11/02/2023.
//

import SwiftUI

struct ForgetPasswordView: View {
    @FocusState var isFocused
    @Binding var config: ActionsViewConfig
    var body: some View {
        VStack {
            Text("In order to reset your password, you need to verify your email first!")
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .fontWeight(.light)
            Spacer()
            TextField("Email", text: $config.email)
                .focused($isFocused)
                .fontWeight(.medium)
                .alignment(edge: .leading, spacing: 10) {
                    Text("@")
                        .fontWeight(.semibold)
                        .opacity(0.5)
                }.padding()
                .frame(height: 45)
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(.gray, lineWidth: 2))
                .padding(.horizontal, 2)
                .padding(.horizontal, 20)
            Spacer()
            Button(action: {
                Task {
                    await config.resetPassword()
                }
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .center(.horizontal)
                    .padding()
                    .frame(height: 45)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }.disabled(config.email.isEmpty)
                .opacity(config.email.isEmpty ? 1: 0.5)
        }.onAppear {
            isFocused = true
        }
    }
}
