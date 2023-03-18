//
//  OTPViewConfig.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

@MainActor class OTPViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var isError: Bool?
    @Published var code = ""
    @Published var received = false
//MARK: - Functions
    func verifyCode(email: String) async {
        isLoading = true
        do {
            _ = try await Network.request(for: AuthenticationRoute.verify(OTPVerification(email: email, otp: code)))
                .retryPolicy(.never)
                .tryCatch(using: ErrorData.self)
                .get()
            isError = false
            isLoading = false
        }catch {
            isLoading = false
            self.isError = true
            print(error)
        }
    }
    func resendCode(email: String) async {
        isLoading = true
        do {
            _ = try await Network.request(for: AuthenticationRoute.sendVerification(email: email))
                .retryPolicy(.never)
                .map({$0 == .ok})
                .get()
            isLoading = false
        }catch {
            isLoading = false
            self.error = error
            print(error)
        }
    }
}
