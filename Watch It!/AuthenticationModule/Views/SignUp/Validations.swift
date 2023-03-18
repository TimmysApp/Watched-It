//
//  Validations.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import Foundation

enum Validations {
    case emptyName, invalidEmail, emailInUse, emptyEmail, invalidPassword, emptyPassword
    var message: String {
        switch self {
            case .emptyName:
                return "The name field is required!"
            case .invalidEmail:
                return "The email entered is invalid!"
            case .emailInUse:
                return "This email is already associated with an account!"
            case .emptyEmail:
                return "The email field is required!"
            case .invalidPassword:
                return "The entered password doesn't meet the following requirements: minimum of 8 characters long, at least one character, one special character & one digit."
            case .emptyPassword:
                return "The password field is required!"
        }
    }
    var field: SignUpField {
        switch self {
            case .emptyName:
                return .name
            case .invalidEmail, .emailInUse, .emptyEmail:
                return .email
            case .invalidPassword, .emptyPassword:
                return .password
        }
    }
}

enum SignUpField: CaseIterable {
    case name, email, password
}
