//
//  File.swift
//  
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct SignUpView: BaseView {
    @Namespace var animationNamespace
    @FocusState var focus: SignUpField?
    @Binding var signIn: Bool
    @StateObject var config = SignUpViewConfig()
    var content: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Let's Get Started!")
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
                        TextField("Name", text: $config.name)
                            .autocorrectionDisabled()
                            .textContentType(.name)
                            .focused($focus, equals: .name)
                            .onSubmit {
                                focus = .email
                            }.roundedFont(weight: .medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "person.fill")
                                    .roundedFont(weight: .semibold)
                                    .opacity(0.5)
                            }.alignment(edge: .trailing) {
                                let filtered = config.validations.filter({$0.field == .name})
                                if !filtered.isEmpty {
                                    Menu(content: {
                                        ForEach(filtered.map({$0.message}), id: \.self) { title in
                                            Text(title)
                                                .roundedFont()
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .roundedFont(.caption, weight: .medium)
                                            .foregroundColor(.red)
                                    }
                                }else if config.validFields.contains(.name) {
                                    Image(systemName: "checkmark")
                                        .roundedFont(.caption, weight: .medium)
                                        .foregroundColor(.green)
                                }
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                            .padding(.top, 20)
                        TextField("Email", text: $config.email)
                            .autocorrectionDisabled()
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .focused($focus, equals: .email)
                            .onSubmit {
                                Task {
                                    focus = .password
                                    await config.checkEmail()
                                }
                            }.roundedFont(weight: .medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Text("@")
                                    .roundedFont(.title3, weight: .semibold)
                                    .opacity(0.5)
                            }.alignment(edge: .trailing) {
                                if config.loadingEmail {
                                    ProgressView()
                                }else {
                                    let filtered = config.validations.filter({$0.field == .email})
                                    if !filtered.isEmpty {
                                        Menu(content: {
                                            ForEach(filtered.map({$0.message}), id: \.self) { title in
                                                Text(title)
                                                    .roundedFont()
                                            }
                                        }) {
                                            Image(systemName: "xmark")
                                                .roundedFont(.caption, weight: .medium)
                                                .foregroundColor(.red)
                                        }
                                    }else if config.validFields.contains(.email) {
                                        Image(systemName: "checkmark")
                                            .roundedFont(.caption, weight: .medium)
                                            .foregroundColor(.green)
                                    }
                                }
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                        SecureTextField("Password", text: $config.password)
                            .autocorrectionDisabled()
                            .textContentType(.newPassword)
                            .focused($focus, equals: .password)
                            .onSubmit {
                                Task {
                                    focus = nil
                                    try? await Task.sleep(nanoseconds: 8_000_000)
                                    config.canSignUp = config.isValid
                                }
                            }.roundedFont(weight: .medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "lock.fill")
                                    .roundedFont(weight: .semibold)
                                    .opacity(0.5)
                            }.alignment(edge: .trailing) {
                                let filtered = config.validations.filter({$0.field == .password})
                                if !filtered.isEmpty {
                                    Menu(content: {
                                        ForEach(filtered.map({$0.message}), id: \.self) { title in
                                            Text(title)
                                                .roundedFont()
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .roundedFont(.caption, weight: .medium)
                                            .foregroundColor(.red)
                                    }
                                }else if config.validFields.contains(.password) {
                                    Image(systemName: "checkmark")
                                        .roundedFont(.caption, weight: .medium)
                                        .foregroundColor(.green)
                                }
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                        Group {
                            if !config.canSignUp {
                                HStack(spacing: 5) {
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                        .roundedFont(weight: .bold)
                                    Image(systemName: "arrow.right")
                                        .roundedFont(weight: .bold)
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "SignUp", in: animationNamespace)
                                }.padding(10)
                                .frame(height: 45)
                                .background(Color.accentColor)
                                .opacity(0.7)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .compositingGroup()
                                .shadow(color: .darkShadow, radius: 6)
                                .pin(to: .trailing)
                                .padding(.horizontal, 20)
                                .disabled(true)
                            }else {
                                SliderView(width: screenWidth - 100) {
                                    Image(systemName: "arrow.right")
                                        .roundedFont(.body, weight: .bold)
                                        .foregroundColor(.white)
                                        .frame(width: 40, height: 40)
                                        .background(Color.accentColor.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 9.5, style: .continuous))
                                        .matchedGeometryEffect(id: "SignUp", in: animationNamespace)
                                }.onCompletion(reseting: true) {
                                    config.signUp()
                                }.overlay(text: "Slide to Sign Up!")
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: .darkShadow, radius: 6)
                            }
                        }.padding(.top, 50)
                        VStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                            Button(action: {
                                signIn.toggle()
                            }) {
                                Text("Sign In")
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
                        Spacer()
                        AuthenticationView.note
                    }.frame(width: reader.size.width, height: reader.size.height)
                        .padding(.horizontal, 30)
                }
                .padding(.horizontal, -30)
            }
        }.onChange(of: config.name) { newValue in
            Task {
                if newValue.count - config.oldName.count > 1 {
                    focus = .email
                }
                await config.check(field: .name)
            }
        }.onChange(of: config.email) { newValue in
            Task {
                if newValue.count - config.oldEmail.count > 1 {
                    focus = .password
                }
                await config.check(field: .email)
            }
        }.onChange(of: config.password) { _ in
            Task {
                await config.check(field: .password)
            }
        }.padding(.horizontal, 30)
        .animation(.spring(), value: config.isValid)
        .animation(.spring(), value: config.canSignUp)
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
