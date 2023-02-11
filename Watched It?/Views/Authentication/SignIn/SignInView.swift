//
//  SignInView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI
import STools

struct SignInView: View {
    @Namespace var animationNamespace
    @FocusState var focus: SignInViewConfig.Field?
    @Environment(\.dismiss) var dismiss
    @Binding var signIn: Bool
    @State var config = SignInViewConfig()
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Welcome Back!")
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
                        TextField("Email", text: $config.email)
                            .textContentType(.emailAddress)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .focused($focus, equals: .email)
                            .onSubmit {
                                focus = .password
                            }.fontWeight(.medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Text("@")
                                    .font(.title3)
                                    .fontWeight(.semibold)
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
                            }.fontWeight(.medium)
                            .alignment(edge: .leading, spacing: 10) {
                                Image(systemName: "lock.fill")
                                    .fontWeight(.semibold)
                                    .opacity(0.5)
                            }.padding()
                            .frame(height: 45)
                            .background(Color.basic.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .compositingGroup()
                            .shadow(color: .darkShadow, radius: 6, y: 8)
                        HStack(spacing: 5) {
                            Text("Forgot Password?")
                                .font(.callout)
                                .fontWeight(.medium)
                            Button(action: {
                                config.sheet = .reset
                            }) {
                                Text("Request Access")
                                    .foregroundColor(.accentColor)
                                    .font(.callout)
                                    .fontWeight(.semibold)
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
                                    .fontWeight(.bold)
                                    .matchedGeometryEffect(id: "SignIn", in: animationNamespace)
                                    .hidden(config.isValid)
                                Spacer()
                                    .hidden(!config.isValid)
                                Image(systemName: "arrow.right")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }.overlay {
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
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
                        AuthenticationView.note
                    }.frame(width: reader.size.width, height: reader.size.height)
                }.disabledBounce()
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
        .onChange(of: config.success) { newValue in
            guard newValue else {return}
            dismiss.callAsFunction()
        }
        .sheet(item: $config.sheet) { item in
            switch item {
                case .verify(let credentials):
                    ActionsView(credentials: credentials, page: .otp)
                case .reset:
                    ActionsView(page: .reset)
            }
        }
        .bindNetwork(initialyLoading: false, withPlaceholder: false)
    }
}
