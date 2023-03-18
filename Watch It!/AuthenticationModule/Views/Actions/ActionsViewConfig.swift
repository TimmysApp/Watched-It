//
//  ActionsViewConfig.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import WatchedItModels
import NetworkUI

@MainActor class ActionsViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var verificationSent = false
    @Published var page: Page
    @Published var password = ""
    @Published var email = ""
    var credentials: UserCredentials?
//MARK: - Initializer
    init(page: Page, credentials: UserCredentials? = nil) {
        self.page = page
        self.credentials = credentials
    }
//MARK: - Mappings
    var isValidPassword: Bool {
        return password == (credentials?.password ?? "")
    }
//MARK: - Functions
    func signUp() async {
        guard let credentials else {return}
        isLoading = true
        do {
            _ = try await Network.request(for: AuthenticationRoute.registration(credentials))
                .retryPolicy(.never)
                .tryDecode(using: AuthSession.self)
                .tryCatch(using: ErrorData.self)
                .get()
            try await sendVerification()
            isLoading = false
            page = .otp
        }catch {
            isLoading = false
            self.error = error
            print(error)
        }
    }
    func sendVerification(resetting: Bool = false) async throws {
        _ = try await Network.request(for: AuthenticationRoute.sendVerification(email: resetting ? email: credentials?.email ?? ""))
            .retryPolicy(.never)
            .tryCatch(using: ErrorData.self)
            .get()
        verificationSent = true
    }
    func resetPassword() async {
        isLoading = true
        do {
            try await sendVerification(resetting: true)
            isLoading = false
        }catch {
            isLoading = false
            self.error = error
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
