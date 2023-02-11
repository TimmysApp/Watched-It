//
//  OTPConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

struct OTPConfig {
//MARK: - Properties
    var error: Bool?
    var received = false
    var code = ""
//MARK: - Functions
    mutating func verifyCode(email: String) async {
        do {
            _ = try await Network.request(for: AuthenticationRoute.verify(OTPVerification(email: email, otp: code)))
                .retryPolicy(.never)
                .handling(.loading)
                .tryCatch(using: ErrorData.self)
                .get()
            error = false
        }catch {
            self.error = true
            print(error)
        }
    }
    func resendCode(email: String) async {
        do {
            let success = try await Network.request(for: AuthenticationRoute.sendVerification(email: email))
                .retryPolicy(.never)
                .handling(.loading)
                .map({$0 == .ok})
                .get()
            guard success else {return}
        }catch {
            print(error)
        }
    }
}
