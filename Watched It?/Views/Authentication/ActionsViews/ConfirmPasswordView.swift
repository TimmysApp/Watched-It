//
//  ConfirmPasswordVieww.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import SwiftUI
import STools

struct ConfirmPasswordView: View {
    @FocusState var isFocused
    @Binding var config: ActionsViewConfig
    var body: some View {
        VStack {
            Text("You need to confirm the password you entered in the previous page before proceeding!")
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .fontWeight(.light)
            Spacer()
            SecureTextField("Confirm Password", text: $config.password)
                .focused($isFocused)
                .fontWeight(.medium)
                .alignment(edge: .leading, spacing: 10) {
                    Image(systemName: "lock.fill")
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
                    await config.signUp()
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
            }.disabled(!config.isValidPassword)
            .opacity(config.isValidPassword ? 1: 0.5)
        }.onAppear {
            isFocused = true
        }
    }
}
