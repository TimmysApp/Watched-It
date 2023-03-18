//
//  Routing.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI

extension SheetRouter {
    @ViewBuilder public var content: some View {
        switch self {
            case .movieOptions:
                Text("")
            case .confirmPassword(let userCredentials):
                ActionsView(credentials: userCredentials, page: .confirm)
            case .verifyOTP(let userCredentials):
                ActionsView(credentials: userCredentials, page: .otp)
            case .resetPass:
                ActionsView(page: .reset)
        }
    }
}

extension FullScreeCoverRouter {
    @ViewBuilder public var content: some View {
        switch self {
            case .authentication:
                AuthenticationView()
        }
    }
}

extension NavigationRouter {
    @ViewBuilder public var content: some View {
        switch self {
            case .allContent(let content):
                SectionDetailsView(content: content)
            case .media(let type):
                Text("")
        }
    }
}
