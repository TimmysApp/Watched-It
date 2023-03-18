//
//  SignUpViewConfig.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

@MainActor class SignUpViewConfig: BaseViewConfig {
//MARK: - Properties
    @Published var validFields = [SignUpField]()
    @Published var validations = [Validations]()
    @Published var loadingEmail = false
    @Published var canSignUp = false
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    var oldName = ""
    var oldEmail = ""
    var oldPassword = ""
    var usedEmails = [String]()
//MARK: - Mappings
    var isValid: Bool {
        return validFields.count == 3
    }
//MARK: - Functions
    func check(field: SignUpField) async {
        validations.removeAll(where: {$0.field == field})
        validFields.removeAll(where: {$0 == field})
        switch field {
            case .email:
                oldEmail = email
                if email.isEmpty {
                    validations.append(.emptyEmail)
                }
                if !email.isValidEmail {
                    validations.append(.invalidEmail)
                }
                if usedEmails.contains(email) {
                    validations.append(.emailInUse)
                }
            case .name:
                oldName = name
                if name.isEmpty {
                    validations.append(.emptyName)
                }
            case .password:
                oldPassword = password
                if password.isEmpty {
                    validations.append(.emptyPassword)
                }
                if !password.isValidPassword {
                    validations.append(.invalidPassword)
                }
        }
        guard !validations.contains(where: {$0.field == field}) && !validFields.contains(field) else {return}
        validFields.append(field)
    }
    func signUp() {
        route(to: .confirmPassword(UserCredentials(email: email, password: password, device: "")))
    }
    func checkEmail() async {
        guard !validations.contains(where: {$0.field == .email}) else {return}
        loadingEmail = true
        do {
            let success = try await Network.request(for: AuthenticationRoute.check(email: email))
                .map({$0 == .ok})
                .get()
            if !success {
                usedEmails.append(email)
                validations.append(.emailInUse)
            }
            loadingEmail = false
        }catch {
            loadingEmail = false
            print(error)
        }
    }
}
