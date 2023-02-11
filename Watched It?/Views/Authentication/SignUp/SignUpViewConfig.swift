//
//  SignUpViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

struct SignUpViewConfig {
//MARK: - Properties
    var presentCode = false
    var requestingAccess = false
    var name = ""
    var email = ""
    var password = ""
    var validFields = [Field]()
    var validations = [Validations]()
    var loadingEmail = false
    var credentials: UserCredentials?
//MARK: - Mappings
    var isValid: Bool {
        return validFields.count == 3
    }
//MARK: - Functions
    mutating func check(field: Field) async {
        validations.removeAll(where: {$0.field == field})
        validFields.removeAll(where: {$0 == field})
        switch field {
            case .email:
                if email.isEmpty {
                    validations.append(.emptyEmail)
                }
                if !email.isValidEmail {
                    validations.append(.invalidEmail)
                }
            case .name:
                if name.isEmpty {
                    validations.append(.emptyName)
                }
            case .password:
                if password.isEmpty {
                    validations.append(.emptyPassword)
                }
        }
        guard !validations.contains(where: {$0.field == field}) && !validFields.contains(field) else {return}
        validFields.append(field)
    }//"^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    mutating func signUp() {
        credentials = UserCredentials(email: email, password: password, device: "")
    }
    mutating func checkEmail() async {
        guard !validations.contains(where: {$0.field == .email}) else {return}
        loadingEmail = true
        do {
            let success = try await Network.request(for: AuthenticationRoute.check(email: email))
                .handling(.none)
                .map({$0 == .ok})
                .get()
            if !success {
                validations.append(.emailInUse)
            }
            loadingEmail = false
        }catch {
            print(error)
            loadingEmail = false
        }
    }
}

//MARK: - Models
extension SignUpViewConfig {
    enum Field: CaseIterable {
        case name, email, password
    }
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
        var field: Field {
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
}
