//
//  OTPView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI
import STools

struct OTPView: View {
    @Environment(\.dismiss) var dismiss
    let email: String
    @Binding var detents: Set<PresentationDetent>
    @State var config = OTPConfig()
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                ScrollView {
                    VStack(spacing: 10) {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.accentColor)
                            .font(.system(size: 90))
                            .fontWeight(.medium)
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                            .padding(.top, 30)
                        (Text("Please enter the ")
                         + Text("code ")
                            .fontWeight(.bold)
                         + Text("\n sent to ")
                         + Text("\(email)")
                            .foregroundColor(.link)
                            .fontWeight(.medium)
                         + Text("in order\nto verify your email."))
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .opacity(0.65)
                        HStack(spacing: 10) {
                            ForEach(0..<6) { _ in
                                TextField("", text: .constant("1"))
                                    .multilineTextAlignment(.center)
                                    .frame(width: (screenWidth - 110)/6, height: (screenWidth - 110)/6)
                                    .background(Color.basic.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                        }.padding(.horizontal, 30)
                        .padding(.top, 50)
                        HStack(spacing: 5) {
                            Text("Didn't receive any email?")
                                .font(.callout)
                            Button(action: {
                                
                            }) {
                                Text("Resend")
                                    .font(.callout)
                                    .fontWeight(.bold)
                            }
                        }.padding(.top, 10)
                    }
                }.disabledBounce()
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .center(.horizontal)
                        .frame(height: 45)
                        .background(Color.accentColor.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: .darkShadow, radius: 6, y: 6)
                }.disabled(true)
                    .padding(.horizontal, 20)
            }.transition(.push(from: .bottom))
                .hidden(!config.received)
            VStack(spacing: 10) {
                Spacer()
                (Text("We have sent an email\n")
                 + Text("containing a 6 digit ")
                 + Text("verification code")
                    .fontWeight(.bold)
                 + Text("\nto ")
                 + Text("\(email)!")
                    .foregroundColor(.link)
                    .fontWeight(.medium))
                .accentColor(.red)
                .multilineTextAlignment(.center)
                .opacity(0.6)
                Spacer()
                HStack(spacing: 5) {
                    Text("Didn't receive any email?")
                        .font(.callout)
                    Button(action: {
                        
                    }) {
                        Text("Resend")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                }
                SliderView(width: screenWidth - 60) {
                    Image(systemName: "arrow.right")
                        .font(.body.weight(.bold))
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
        }
    }
}
