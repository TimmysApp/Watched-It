//
//  ForgetPasswordView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct ForgetPasswordView: View {
    @FocusState var isFocused
    @ObservedObject var config: ActionsViewConfig
    var body: some View {
        VStack {
            Text("In order to reset your password, you need to verify your email first!")
                .roundedFont(.callout, weight: .light)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            Spacer()
            TextField("Email", text: $config.email)
                .focused($isFocused)
                .roundedFont(weight: .medium)
                .alignment(edge: .leading, spacing: 10) {
                    Text("@")
                        .roundedFont(weight: .semibold)
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
                    .roundedFont(weight: .semibold)
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
