//
//  ConfirmPasswordViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import Foundation
import WatchedItModels
import NetworkUI

struct ActionsViewConfig {
//MARK: - Properties
    var verificationSent = false
    var page: Page
    var password = ""
    var email = ""
    var credentials: UserCredentials?
//MARK: - Mappings
    var isValidPassword: Bool {
        return password == (credentials?.password ?? "")
    }
//MARK: - Functions
    mutating func signUp() async {
        guard let credentials else {return}
        do {
            _ = try await Network.request(for: AuthenticationRoute.registration(credentials))
                .handling(.loading)
                .retryPolicy(.never)
                .tryDecode(using: AuthSession.self)
                .tryCatch(using: ErrorData.self)
                .get()
            try await sendVerification()
            page = .otp
        }catch {
            print(error)
        }
    }
    mutating func sendVerification(resetting: Bool = false) async throws {
        _ = try await Network.request(for: AuthenticationRoute.sendVerification(email: resetting ? email: credentials?.email ?? ""))
            .retryPolicy(.never)
            .handling(.loading)
            .tryCatch(using: ErrorData.self)
            .get()
        verificationSent = true
    }
    mutating func resetPassword() async {
        do {
            try await sendVerification(resetting: true)
        }catch {
            print(error)
        }
    }
}

//MARK: - Models
extension ActionsViewConfig {
    enum Page: Int, Identifiable {
        case confirm, otp, reset
        var id: Int {
            return rawValue
        }
        var title: String {
            switch self {
                case .confirm:
                    return "Password Confirmation"
                case .otp:
                    return "Email Verification"
                case .reset:
                    return "Account Recovery"
            }
        }
    }
}
