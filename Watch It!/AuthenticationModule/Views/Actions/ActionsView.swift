//
//  ActionsView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools
import WatchedItModels

struct ActionsView: BaseView {
    @State var detents: Set<PresentationDetent> = [.height(300)]
    @Environment(\.dismiss) var dismiss
    @StateObject var config: ActionsViewConfig
    init(credentials: UserCredentials? = nil, page: ActionsViewConfig.Page) {
        _config = StateObject(wrappedValue: ActionsViewConfig(page: page, credentials: credentials))
    }
    var content: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack {
                    Text(config.page.title)
                        .roundedFont(.title3, weight: .semibold)
                    Spacer()
                    Button(action: {
                        dismiss.callAsFunction()
                    }) {
                        Text("Close")
                            .roundedFont(weight: .semibold)
                    }
                }.padding(.vertical)
                RoundedRectangle(cornerRadius: 1, style: .continuous)
                    .fill(Color.gray)
                    .frame(height: 2)
                    .padding(.horizontal, -20)
            }
            Group {
                if config.page == .confirm {
                    ConfirmPasswordView(config: config)
                }else if config.page == .otp {
                    OTPView(email: config.credentials?.email ?? config.email, detents: $detents)
                }else if config.page == .reset {
                    ForgetPasswordView(config: config)
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
