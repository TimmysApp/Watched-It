//
//  SignInViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

struct SignInViewConfig {
//MARK: - Properties
    var sheet: Sheet?
    var success = false
    var email = ""
    var password = ""
//MARK: - Mappings
    var isValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
//MARK: - Functions
    mutating func signIn() async {
        do {
            let session = try await Network.request(for: AuthenticationRoute.signIn(UserCredentials(email: email, password: password, device: "")))
                .tryDecode(using: AuthSession.self)
                .tryCatch(using: ErrorData.self)
                .retryPolicy(.never)
                .get()
            WatchedIt.storage.authSession = session
            success = true
        }catch {
            print(error)
            guard let errorData = error as? ErrorData, errorData.action == .shouldVerify else {
                return
            }
            await sendVerification()
        }
    }
    mutating func sendVerification() async {
        do {
            _ = try await Network.request(for: AuthenticationRoute.sendVerification(email: email))
                .retryPolicy(.never)
                .tryCatch(using: ErrorData.self)
                .get()
            sheet = .verify(UserCredentials(email: email, password: password, device: ""))
        }catch {
            print(error)
        }
    }
}

//MARK: - Models
extension SignInViewConfig {
    enum Field {
        case email, password
    }
    enum Sheet: Identifiable {
        case verify(UserCredentials), reset
        var id: Int {
            switch self {
                case .verify:
                    return 0
                case .reset:
                    return 1
            }
        }
    }
}
