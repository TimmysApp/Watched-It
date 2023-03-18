//
//  SignInViewConfig.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

@MainActor class SignInViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var email = ""
    @Published var password = ""
//MARK: - Mappings
    var isValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
//MARK: - Functions
    func signIn() async {
        isLoading = true
        do {
            let session = try await Network.request(for: AuthenticationRoute.signIn(UserCredentials(email: email, password: password, device: "")))
                .tryDecode(using: AuthSession.self)
                .tryCatch(using: ErrorData.self)
                .retryPolicy(.never)
                .get()
            Storage.authSession = session
            isLoading = false
            dismiss()
        }catch {
            isLoading = false
            print(error)
            guard let errorData = error as? ErrorData else {return}
            if errorData.action == .shouldVerify {
                await sendVerification()
            }else {
                self.error = error
            }
        }
    }
    func sendVerification() async {
        do {
            _ = try await Network.request(for: AuthenticationRoute.sendVerification(email: email))
                .retryPolicy(.never)
                .tryCatch(using: ErrorData.self)
                .get()
            route(to: .verifyOTP(UserCredentials(email: email, password: password, device: "")))
            isLoading = false
        }catch {
            isLoading = false
            self.error = error
            print(error)
        }
    }
}

//MARK: - Models
extension SignInViewConfig {
    enum Field {
        case email, password
    }
}
