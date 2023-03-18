//
//  OTPView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct OTPView: View {
    @Environment(\.dismiss) var dismiss
    let email: String
    @Binding var detents: Set<PresentationDetent>
    @StateObject var config = OTPViewConfig()
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                ScrollView {
                    VStack(spacing: 10) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.accentColor)
                            .roundedFont(.custom(90), weight: .medium)
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                            .padding(.top, 30)
                        (Text("Please enter the ")
                            .roundedFont()
                         + Text("code ")
                            .roundedFont(weight: .bold)
                         + Text("\n sent to ")
                            .roundedFont()
                         + Text("\(email)")
                            .roundedFont(weight: .medium)
                            .foregroundColor(.link)
                         + Text(" in order\nto verify your email.")
                            .roundedFont())
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .opacity(0.65)
                        OTPFieldView(code: $config.code, error: config.isError)
                            .padding(.horizontal, 30)
                            .padding(.top, 50)
                        HStack(spacing: 5) {
                            Text("Didn't receive any email?")
                                .roundedFont(.callout)
                            Button(action: {
                                Task {
                                    await config.resendCode(email: email)
                                }
                            }) {
                                Text("Resend")
                                    .roundedFont(.callout, weight: .bold)
                            }
                        }.padding(.top, 10)
                    }
                }//.disabledBounce()
                Spacer()
                Button(action: {
                    Task {
                        await config.verifyCode(email: email)
                    }
                }) {
                    Text("Submit")
                        .roundedFont(weight: .semibold)
                        .foregroundColor(.white)
                        .center(.horizontal)
                        .frame(height: 45)
                        .background(Color.accentColor.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: .darkShadow, radius: 6, y: 6)
                }.disabled(config.code.count < 6)
                .padding(.horizontal, 20)
            }.transition(.push(from: .bottom))
            .hidden(!config.received)
            VStack(spacing: 10) {
                Spacer()
                (Text("We have sent an email\n")
                    .roundedFont()
                 + Text("containing a 6 digit ")
                    .roundedFont()
                 + Text("verification code")
                    .roundedFont(weight: .bold)
                 + Text("\nto ")
                    .roundedFont()
                 + Text("\(email)!")
                    .roundedFont(weight: .medium))
                    .foregroundColor(.link)
                .accentColor(.red)
                .multilineTextAlignment(.center)
                .opacity(0.7)
                Spacer()
                HStack(spacing: 5) {
                    Text("Didn't receive any email?")
                        .roundedFont(.callout)
                    Button(action: {
                        Task {
                            await config.resendCode(email: email)
                        }
                    }) {
                        Text("Resend")
                            .roundedFont(.callout, weight: .bold)
                    }
                }
                SliderView(width: screenWidth - 60) {
                    Image(systemName: "arrow.right")
                        .roundedFont(.body, weight: .bold)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.accentColor.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 9.5, style: .continuous))
                }.onCompletion {
                    detents = [.large]
                }.overlay(text: "Slide to verify your email!")
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .darkShadow, radius: 6, y: 6)
            }.transition(.push(from: .bottom))
            .hidden(config.received)
        }.animation(.easeInOut, value: config.received)
        .onChange(of: detents) { _ in
            Task {
                try? await Task.sleep(nanoseconds: 5_000_000)
                config.received = true
            }
        }.onChange(of: config.isError) { newValue in
            guard newValue == false else {return}
            Task {
                try? await Task.sleep(nanoseconds: 1_005_000_000)
                dismiss.callAsFunction()
            }
        }
    }
}
