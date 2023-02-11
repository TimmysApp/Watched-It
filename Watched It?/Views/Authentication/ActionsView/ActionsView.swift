//
//  ConfirmPasswordView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import SwiftUI
import STools
import WatchedItModels

struct ActionsView: View {
    @State var detents: Set<PresentationDetent> = [.height(300)]
    @Environment(\.dismiss) var dismiss
    @State var config: ActionsViewConfig
    init(credentials: UserCredentials? = nil, page: ActionsViewConfig.Page) {
        _config = State(initialValue: ActionsViewConfig(page: page, credentials: credentials))
    }
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack {
                    Text(config.page.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        dismiss.callAsFunction()
                    }) {
                        Text("Close")
                            .fontWeight(.semibold)
                    }
                }.padding(.vertical)
                RoundedRectangle(cornerRadius: 1, style: .continuous)
                    .fill(Color.gray)
                    .frame(height: 2)
                    .padding(.horizontal, -20)
            }
            Group {
                if config.page == .confirm {
                    ConfirmPasswordView(config: $config)
                }else if config.page == .otp {
                    OTPView(email: config.credentials?.email ?? config.email, detents: $detents)
                }else if config.page == .reset {
                    ForgetPasswordView(config: $config)
                }
            }.padding(.bottom, 20)
            .transition(.slide)
            .animation(.easeInOut, value: config.page)
        }.onChange(of: config.verificationSent) { _ in
            Task {
                detents = [.height(300)]
                try? await Task.sleep(nanoseconds: 5_000_000)
                config.page = .otp
            }
        }.padding(.horizontal, 20)
        .background(Color.sheetBackground)
        .presentationDetents(detents)
        .presentationDragIndicator(.visible)
        .accentColor(.button)
    }
}
