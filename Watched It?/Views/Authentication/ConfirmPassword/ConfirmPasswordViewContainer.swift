//
//  ConfirmPasswordView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import SwiftUI
import STools
import WatchedItModels

struct ConfirmPasswordViewContainer: View {
    @State var detents: Set<PresentationDetent> = [.medium]
    @Environment(\.dismiss) var dismiss
    @State var config: ConfirmPasswordViewConfig
    init(credentials: UserCredentials) {
        _config = State(initialValue: ConfirmPasswordViewConfig(credentials: credentials))
    }
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack {
                    Text(config.page.title)
                        .foregroundColor(.white)
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
                }else {
                    OTPView(email: config.credentials.email, detents: $detents)
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
