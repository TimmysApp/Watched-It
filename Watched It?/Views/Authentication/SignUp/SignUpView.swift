//
//  SignUpView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI
import STools

struct SignUpView: View {
    @Namespace var animationNamespace
    @FocusState var focus: SignUpViewConfig.Field?
    @Binding var signIn: Bool
    @State var config = SignUpViewConfig()
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Let's Get Started!")
                    .font(.title)
                    .fontWeight(.bold)
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
                                .fontWeight(.light)
                             + Text("Slothing")
                                .fontWeight(.semibold)
                             + Text(" account!")
                                .fontWeight(.light))
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
                            }.fontWeight(.medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "person.fill")
                                    .fontWeight(.semibold)
                                    .opacity(0.5)
                            }.alignment(edge: .trailing) {
                                let filtered = config.validations.filter({$0.field == .name})
                                if !filtered.isEmpty {
                                    Menu(content: {
                                        ForEach(filtered.map({$0.message}), id: \.self) { title in
                                            Text(title)
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(.red)
                                    }
                                }else if config.validFields.contains(.name) {
                                    Image(systemName: "checkmark")
                                        .font(.caption)
                                        .fontWeight(.medium)
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
                            }.fontWeight(.medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Text("@")
                                    .font(.title3)
                                    .fontWeight(.semibold)
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
                                            }
                                        }) {
                                            Image(systemName: "xmark")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .foregroundColor(.red)
                                        }
                                    }else if config.validFields.contains(.email) {
                                        Image(systemName: "checkmark")
                                            .font(.caption)
                                            .fontWeight(.medium)
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
                                focus = nil
                            }.fontWeight(.medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "lock.fill")
                                    .fontWeight(.semibold)
                                    .opacity(0.5)
                            }.alignment(edge: .trailing) {
                                let filtered = config.validations.filter({$0.field == .password})
                                if !filtered.isEmpty {
                                    Menu(content: {
                                        ForEach(filtered.map({$0.message}), id: \.self) { title in
                                            Text(title)
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(.red)
                                    }
                                }else if config.validFields.contains(.password) {
                                    Image(systemName: "checkmark")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.green)
                                }
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                        Group {
                            if !config.isValid {
                                HStack(spacing: 5) {
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                    Image(systemName: "arrow.right")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "SignUp", in: animationNamespace)
                                }.padding(10)
                                    .frame(height: 45)
                                    .background(Color.gray)
                                    .opacity(0.3)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: .darkShadow, radius: 6)
                                    .pin(to: .trailing)
                                    .padding(.horizontal, 20)
                            }else {
                                SliderView(width: screenWidth - 100) {
                                    Image(systemName: "arrow.right")
                                        .font(.body.weight(.bold))
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
                                    .fontWeight(.bold)
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
                                    .fontWeight(.bold)
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
                        (Text("Please note that ")
                            .fontWeight(.light)
                         + Text("Slothing")
                            .fontWeight(.semibold)
                         + Text(" accounts are independent of ")
                            .fontWeight(.light)
                         + Text("Watched It.")
                            .fontWeight(.semibold)
                         + Text(" Refer to our ")
                            .fontWeight(.light)
                         + Text("Terms & Conditions")
                            .fontWeight(.medium)
                            .foregroundColor(.link)
                         + Text(", & ")
                            .fontWeight(.light)
                         + Text("Privacy Policy")
                            .fontWeight(.medium)
                            .foregroundColor(.link)
                         + Text(" for more info.")
                            .fontWeight(.light)
                        ).font(.caption2)
                            .multilineTextAlignment(.center)
                            .opacity(0.6)
                            .padding(.bottom, 30)
                    }.frame(width: reader.size.width, height: reader.size.height)
                }.disabledBounce()
            }
        }.onChange(of: config.name) { _ in
            Task {
                await config.check(field: .name)
            }
        }.onChange(of: config.email) { _ in
            Task {
                await config.check(field: .email)
            }
        }.onChange(of: config.password) { _ in
            Task {
                await config.check(field: .password)
            }
        }.padding(.horizontal, 30)
        .animation(.spring(), value: config.isValid)
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
            .sheet(item: $config.credentials) { item in
                ConfirmPasswordViewContainer(credentials: item)
            }.bindNetwork(initialyLoading: false, withPlaceholder: false)
    }
}
