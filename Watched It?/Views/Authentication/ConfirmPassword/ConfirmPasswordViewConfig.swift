//
//  ConfirmPasswordViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import Foundation
import WatchedItModels
import NetworkUI

struct ConfirmPasswordViewConfig {
//MARK: - Properties
    var verificationSent = false
    var page = Page.confirm
    var password = ""
    var credentials: UserCredentials
//MARK: - Mappings
    var isValid: Bool {
        return password == credentials.password
    }
//MARK: - Functions
    mutating func signUp() async {
        page = .otp
        do {
            let session = try await Network.request(for: AuthenticationRoute.registration(credentials))
                .retryPolicy(.never)
                .tryDecode(using: AuthSession.self)
                .tryCatch(using: ErrorData.self)
                .get()
            WatchedIt.storage.authSession = session
            await sendVerification()
        }catch {
            print(error)
        }
    }
    mutating func sendVerification() async {
        do {
            let success = try await Network.request(for: AuthenticationRoute.sendVerification(email: credentials.email))
                .retryPolicy(.never)
                .map({$0 == .ok})
                .get()
            guard success else {return}
            verificationSent = true
        }catch {
            print(error)
        }
    }
}

//MARK: - Models
extension ConfirmPasswordViewConfig {
    enum Page: Int, Identifiable {
        case confirm, otp
        var id: Int {
            return rawValue
        }
        var title: String {
            switch self {
                case .confirm:
                    return "Password Confirmation"
                case .otp:
                    return "Email Verification"
            }
        }
    }
}
