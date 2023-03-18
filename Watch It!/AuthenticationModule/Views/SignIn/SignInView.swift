//
//  SignInView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct SignInView: BaseView {
    @Namespace var animationNamespace
    @FocusState var focus: SignInViewConfig.Field?
    @Environment(\.dismiss) var dismiss
    @Binding var signIn: Bool
    @StateObject var config = SignInViewConfig()
    var content: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Welcome Back!")
                    .roundedFont(.title, weight: .bold)
                    .opacity(0.7)
                    .shadow(radius: 5)
                Spacer()
                BackButtonView()
                    .closingStyle()
            }.padding(.top, 50)
            GeometryReader { reader in
                ScrollView {
                    VStack(spacing: 10) {
                        VStack(spacing: 0) {
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .accentColor(.inverseBasic)
                            (Text("My ")
                                .roundedFont(weight: .light)
                             + Text("Slothing")
                                .roundedFont(weight: .semibold)
                             + Text(" account!")
                                .roundedFont(weight: .light))
                            .padding(.top, -18)
                        }.padding(.vertical, 20)
                        .opacity(0.7)
                        .shadow(radius: 5)
                        TextField("Email", text: $config.email)
                            .textContentType(.emailAddress)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .focused($focus, equals: .email)
                            .onSubmit {
                                focus = .password
                            }.roundedFont(weight: .medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Text("@")
                                    .roundedFont(.title3, weight: .semibold)
                                    .opacity(0.5)
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                            .padding(.top, 20)
                        SecureTextField("Password", text: $config.password)
                            .autocorrectionDisabled()
                            .textContentType(.newPassword)
                            .focused($focus, equals: .password)
                            .onSubmit {
                                focus = nil
                            }.roundedFont(weight: .medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "lock.fill")
                                    .roundedFont(weight: .semibold)
                                    .opacity(0.5)
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                        HStack(spacing: 5) {
                            Text("Forgot Password?")
                                .roundedFont(.callout, weight: .light)
                            Button(action: {
                                config.route(to: .resetPass)
                            }) {
                                Text("Request Access")
                                    .foregroundColor(.accentColor)
                                    .roundedFont(.callout, weight: .semibold)
                            }
                        }
                        Button(action: {
                            Task {
                                await config.signIn()
                            }
                        }) {
                            HStack {
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .roundedFont(weight: .bold)
                                    .matchedGeometryEffect(id: "SignIn", in: animationNamespace)
                                    .hidden(config.isValid)
                                Spacer()
                                    .hidden(!config.isValid)
                                Image(systemName: "arrow.right")
                                    .roundedFont(weight: .bold)
                                    .foregroundColor(.white)
                            }.overlay {
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .roundedFont(weight: .bold)
                                    .matchedGeometryEffect(id: "SignIn", in: animationNamespace)
                                    .hidden(!config.isValid)
                            }.padding()
                            .frame(height: 45)
                            .background(Color.accentColor)
                            .opacity(0.7)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .animation(.spring(), value: config.isValid)
                        }.disabled(!config.isValid)
                        .padding(.top, 50)
                        VStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                            Button(action: {
                                signIn.toggle()
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(.accentColor)
                                    .roundedFont(weight: .bold)
                                    .center(.horizontal)
                                    .padding()
                                    .frame(height: 45)
                                    .background(Color.white.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: .darkShadow, radius: 6)
                                    .pin(to: .trailing)
                            }.padding(10)
                            .padding(.horizontal, 15)
                            Button(action: {
                                signIn.toggle()
                            }) {
                                Text("Continue with \(Image(systemName: "applelogo"))")
                                    .foregroundColor(.white)
                                    .roundedFont(weight: .bold)
                                    .center(.horizontal)
                                    .padding()
                                    .frame(height: 45)
                                    .background(Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: .darkShadow, radius: 6)
                                    .pin(to: .trailing)
                            }.padding(.horizontal, 25)
                        }.padding(.top, 20)
                        Spacer(minLength: 0)
                        AuthenticationView.note
                    }.frame(width: reader.size.width, height: reader.size.height)
                    .padding(.horizontal, 30)
                }.padding(.horizontal, -30)
            }
        }.padding(.horizontal, 30)
        .background {
            Color.basic
                .opacity(0.7)
                .background {
                    Image("Mask")
                        .resizable()
                        .blur(radius: 30)
                }.edgesIgnoringSafeArea(.all)
        }.clipped()
        .toolbar(.hidden, for: .navigationBar)
    }
}
