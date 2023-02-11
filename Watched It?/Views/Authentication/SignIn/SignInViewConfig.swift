//
//  SignInViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI

struct SignInViewConfig {
//MARK: - Properties
    var requestingAccess = false
    var email = ""
    var password = ""
//MARK: - Mappings
    var isValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
//MARK: - Functions
    mutating func signIn() async {
    }
}

//MARK: - Models
extension SignInViewConfig {
    enum Field {
        case email, password
    }
}
